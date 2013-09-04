desc "Get tournament games"
task :get_tournament_games => :environment do
  require 'open-uri'
  require 'json'
  
  League.all.each do |league|  
    url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=#{ENV['STEAM_KEY']}&league_id=#{league.id}"
    content = open(url).read
    output = JSON.parse(content)
    
    while true
      output["result"]["matches"].each do |match|
        match_id = match["match_id"]
        db_match = Match.find_by_id(match_id)
        
        match_url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?match_id=#{match_id}&key=#{ENV['STEAM_KEY']}"
        match_content = open(match_url).read
        match_output = JSON.parse(match_content)
        
        if db_match != nil
          if MatchTeam.find_by_match_id(db_match.id) == nil
            MatchTeam.create({
              match_id: db_match.id,
              radiant_team_id: match_output["result"]["radiant_team_id"],
              dire_team_id: match_output["result"]["dire_team_id"],
              radiant_logo: match_output["result"]["radiant_logo"],
              dire_logo: match_output["result"]["dire_logo"]
            })
          end
          next
        end
        
        m = Match.new({duration: match_output["result"]["duration"],
                           game_mode: match_output["result"]["game_mode"],
                           radiant_win: match_output["result"]["radiant_win"]})
        m.id = match_id
        m.save
        
        league.matches << m
      
        match_output["result"]["players"].each do |player|
          PlayerMatch.create({
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
            xp_per_min: player["xp_per_min"]
          })
        end
        
        MatchTeam.create({
          match_id: m.id,
          radiant_team_id: match_output["result"]["radiant_team_id"],
          dire_team_id: match_output["result"]["dire_team_id"],
          radiant_logo: match_output["result"]["radiant_logo"],
          dire_logo: match_output["result"]["dire_logo"]
        })
        
      end
      
      break if output["result"]["results_remaining"] == 0
      
      last_match = league.matches.order("id ASC").first
      last_match_id = last_match.id
      
      url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=#{ENV['STEAM_KEY']}&league_id=#{league.id}&start_at_match_id=#{last_match_id - 1}"
      content = open(url).read
      output = JSON.parse(content)
    end
  end
end