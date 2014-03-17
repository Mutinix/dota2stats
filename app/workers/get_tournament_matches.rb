class GetTournamentMatches
  @queue = :matches_queue
  
  def self.perform(api_key)
    require 'open-uri'
    require 'json'
    
    logger = Logger.new(STDOUT)
    
    League.all.reverse.each do |league|
      begin
        url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=#{api_key}&league_id=#{league.id}"
        content = open(url).read
        output = JSON.parse(content)
      rescue => e
        if e === OpenURI::HTTPError or e === Errno::ECONNRESET
          sleep 60
          logger.error "Error encountered - #{e}"
          retry
        end
      end
      
      if output == nil
        logger.warn "Output is nil."
        logger.info "Finished processing league #{league.id} - #{league.name}"
        next
      end
      
      logger.info "Currently processing league #{league.id} - #{league.name}"
      logger.info "Total matches: #{output['result']['total_results']}"
      
      while true
        
        if output["result"]["matches"] == []
          logger.info "Matches array is empty."
        end
      
        output["result"]["matches"].each do |match|
          sleep 0.75
          match_id = match["match_id"]
          mh = Match.find_by_id(match_id)
          if mh != nil
            logger.info "Match #{match_id} already exists."
            if mh.league_id != league.id
              logger.info "league_id updated from nil to #{league.id}" unless mh.league_id
              mh.league_id = league.id
              mh.save
            end
            next
          end
          
          begin
            match_url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?match_id=#{match_id}&key=#{api_key}"
            match_content = open(match_url).read
            match_output = JSON.parse(match_content)
            match_result = match_output["result"]
          rescue => e
            if e === OpenURI::HTTPError or e === Errno::ECONNRESET
              sleep 30
              logger.error "Error encountered - #{e}"
              retry
            end
          end
        
          if match_result == nil
            logger.warn "match_result is empty."
          end
          
          logger.info "Currently processing match #{match_id}"
          
          m = Match.new({ duration: match_result["duration"],
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
                          league_id: match_result["leagueid"]
                              })
          m.id = match_id 
          unless m.save
            logger.warn "Match could not be saved."
          end
          
          logger.debug "Created entry for match."
      
          if match_result["picks_bans"]
            logger.debug "Processing picks and bans."
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
          
            pm["tower_damage"] = 0 if pm["tower_damage"] > 2147483647
            pm["hero_healing"] = 0 if pm["hero_healing"] > 2147483647
            pm["hero_damage"] = 0 if pm["hero_damage"] > 2147483647
            pm.save
        
            if player["ability_upgrades"]
              logger.debug "Processing ability upgrades."
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
              logger.debug "Processing additional units."
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
        
        logger.info "Matches remaining: #{output["result"]["results_remaining"]}"
        
        if output["result"]["results_remaining"] == 0
          logger.info "Finished processing league #{league.id} - #{league.name}"
          break
        end
        
        last_match_id = output["result"]["matches"][-1]["match_id"]
        # last_match = league.matches.order("id ASC").first
        # break unless last_match
        # last_match_id = last_match.id
        
        url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=#{ENV['STEAM_KEY']}&league_id=#{league.id}&start_at_match_id=#{last_match_id}"
        content = open(url).read
        output = JSON.parse(content)
      end
    end
  end
  
  # def self.on_failure_retry(error, *args)
  #   sleep 60
  #   Resque.enqueue self, *args
  # end
  
end