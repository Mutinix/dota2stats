desc "Create new teams"
task :create_teams => :environment do
  require 'open-uri'
  require 'json'
  
  last_team_id = (Team.last ? Team.last.id : -99)
  
  while last_team_id != (Team.last ? Team.last.id : 0)
    last_team_id += 100
    url = "https://api.steampowered.com/IDOTA2Match_570/GetTeamInfoByTeamID/V001/?start_at_team_id=#{last_team_id}&key=#{STEAM_KEY}"
    content = open(url).read
    output = JSON.parse(content)

    output["result"]["teams"].each do |team|
      if team["league_id_0"] == nil || Team.find_by_id(team["team_id"]) != nil
        next
      end
      t = Team.new({name: team["name"], tag: team["tag"], country_code: team["country_code"], url: team["url"]})
      t.id = team["team_id"]
      t.save
    end
  end
end