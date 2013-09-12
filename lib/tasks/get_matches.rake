desc "Get matches"
task :get_matches => :environment do
  require 'open-uri'
  require 'json'
  
  while true
    last_match = Match.order("match_seq_num DESC").first
    if last_match != nil
      last_match_seq = last_match.match_seq_num
      url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchHistoryBySequenceNum/V001/?start_at_match_seq_num=#{last_match_seq + 1}&key=#{ENV['STEAM_KEY']}"
    else
      url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchHistoryBySequenceNum/V001/?key=#{ENV['STEAM_KEY']}"
    end
    content = open(url).read
    output = JSON.parse(content)
      
    output["result"]["matches"].each do |match|
      match_id = match["match_id"]
      next if Match.find_by_id(match_id) != nil
      match_url = "https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?match_id=#{match_id}&key=#{ENV['STEAM_KEY']}"
      match_content = open(match_url).read
      match_output = JSON.parse(match_content)
      match_result = match_output["result"]
      m = Match.new({duration: match_result["duration"],
                         game_mode: match_result["game_mode"],
                         radiant_win: match_result["radiant_win"],
                         match_seq_num: match_result["match_seq_num"]})
      m.id = match_id
      m.save
    
      match_result["players"].each do |player|
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
          xp_per_min: player["xp_per_min"],
          start_time: player["start_time"]
        })
      end
      
    end
    
  end
  
end