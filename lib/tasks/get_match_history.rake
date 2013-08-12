desc "Get match history"
task :get_match_history => :environment do
  require 'open-uri'
  require 'json'
  
  User.all.each do |user|
    uid = user.uid
    uid = SteamIDConvert(64, Integer(uid))
    last_match = user.matches.first
    if last_match != nil
      last_match_id = last_match.id
      url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?account_id=#{uid}&start_at_match_id=#{last_match_id - 1}&key=#{STEAM_KEY}"
    else
      url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?account_id=#{uid}&key=#{STEAM_KEY}"
    end
    content = open(url).read
    output = JSON.parse(content)
    while output["result"]["results_remaining"] >= 0
      output["result"]["matches"].each do |match|
        match_id = match["match_id"]
        match_url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?match_id=#{match_id}&key=#{STEAM_KEY}"
        match_content = open(match_url).read
        match_output = JSON.parse(match_content)
        result = match_output["result"]
        next if PlayerMatch.where({match_id: match_id, player_id: uid}) != []
        match = Match.new({duration: result["duration"],
                           game_mode: result["game_mode"],
                           radiant_win: result["radiant_win"]})
        match.id = match_id
        match.save
      
        result["players"].each do |player|
          next if PlayerMatch.where({match_id: match_id, player_id: player["id"]}) != []
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
      
      end
      last_match = user.matches.first
      
      ###################
      # p last_match.id #
      ###################
      
      last_match_id = last_match.id
      url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?account_id=#{uid}&start_at_match_id=#{last_match_id - 1}&key=#{STEAM_KEY}"
      content = open(url).read
      output = JSON.parse(content)
    end
  end
end