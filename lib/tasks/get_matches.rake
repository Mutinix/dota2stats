desc "Get matches"
task :get_matches => :environment do
  require 'open-uri'
  require 'json'
  
  count = 0
  
  while count <= 80000
    last_match = Match.order("match_seq_num DESC").first
    if last_match != nil
      last_match_seq = last_match.match_seq_num
      url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchHistoryBySequenceNum/V001/?start_at_match_seq_num=#{last_match_seq + 1}&key=#{ENV['STEAM_KEY']}"
    else
      url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchHistoryBySequenceNum/V001/?key=#{ENV['STEAM_KEY']}"
    end
    content = open(url).read
    output = JSON.parse(content)
    break if output["result"]["matches"] == []
      
    output["result"]["matches"].each do |match|
      count += 1
      match_id = match["match_id"]
      next if Match.find_by_id(match_id) != nil
      match_url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?match_id=#{match_id}&key=#{ENV['STEAM_KEY']}"
      match_content = open(match_url).read
      match_output = JSON.parse(match_content)
      match_result = match_output["result"]
      m = Match.new({    duration: match_result["duration"],
                         game_mode: match_result["game_mode"],
                         radiant_win: match_result["radiant_win"],
                         match_seq_num: match_result["match_seq_num"],
                         start_time: match_result["start_time"],
                         lobby_type: match_result["lobby_type"],
                         tower_status_radiant: match_result["tower_status_radiant"],
                         tower_status_dire: match_result["tower_status_dire"],
                         barracks_status_radiant: match_result["barracks_status_radiant"],
                         barracks_status_dire: match_result["barracks_status_dire"],
                         cluster: match_result["cluster"],
                         first_blood_time: match_result["first_blood_time"],
                         human_players: match_result["human_players"],
                         positive_votes: match_result["positive_votes"],
                         negative_votes: match_result["negative_votes"],
                         leagueid: match_result["leagueid"]
                          })
      m.id = match_id      
      m.save
      
      if match_result["picks_bans"]
        match_result["picks_bans"].each do |selection|
          PickBan.create({
            is_pick: selection["is_pick"],
            hero_id: selection["hero_id"],
            team: selection["team"],
            order: selection["order"],
            match_id: match_id
          })
        end
      end
      
      if match_result["leagueid"] != 0
        MatchTeam.create({
          match_id: match_id,
          radiant_team_id: match_result["radiant_team_id"],
          radiant_logo: match_result["radiant_logo"],
          radiant_team_complete: match_result["radiant_team_complete"],
          radiant_guild_id: match_result["radiant_guild_id"],
          radiant_guild_name: match_result["radiant_guild_name"],
          radiant_guild_logo: match_result["radiant_guild_logo"],
          dire_team_id: match_result["dire_team_id"],
          dire_logo: match_result["dire_logo"],
          dire_team_complete: match_result["dire_team_complete"],
          dire_guild_id: match_result["dire_guild_id"],
          dire_guild_name: match_result["dire_guild_name"],
          dire_guild_logo: match_result["dire_guild_logo"]
        })
      end
    
      match_result["players"].each do |player|
        pm = PlayerMatch.new({
          assists: player["assists"],
          deaths: player["deaths"],
          denies: player["denies"],
          gold: player["gold"],
          gold_per_min: player["gold_per_min"],
          gold_spent: player["gold_spent"],
          hero_id: player["hero_id"],
          item_0: player["item_0"], 
          item_1: player["item_1"],
          item_2: player["item_2"],
          item_3: player["item_3"],
          item_4: player["item_4"],
          item_5: player["item_5"],
          kills: player["kills"],
          last_hits: player["last_hits"],
          level: player["level"],
          match_id: match_id,
          player_id: player["account_id"],
          player_slot: player["player_slot"],
          xp_per_min: player["xp_per_min"],
          hero_damage: player["hero_damage"],
          tower_damage: player["tower_damage"],
          hero_healing: player["hero_healing"],
          leaver_status: player["leaver_status"]
        })
        
        pm["tower_damage"] = 0 if pm["tower_damage"] == 4294967295
        pm.save
        
        if player["ability_upgrades"]
          player["ability_upgrades"].each do |ability_upgrade|
            AbilityUpgrade.create({
              ability_id: ability_upgrade["ability"],
              level: ability_upgrade["level"],
              player_match_id: pm.id,
              time: ability_upgrade["time"]
            })
          end
        end
        
        if player["additional_units"]
          player["additional_units"].each do |additional_unit|
            AdditionalUnit.create({
              unitname: additional_unit["unitname"],
              item_0: additional_unit["item_0"],
              item_1: additional_unit["item_1"],
              item_2: additional_unit["item_2"],
              item_3: additional_unit["item_3"],
              item_4: additional_unit["item_4"],
              item_5: additional_unit["item_5"],
              player_match_id: pm.id
            })
          end
        end
        
      end
      
    end
    
  end
  
end