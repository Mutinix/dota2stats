require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

desc "Create team rosters"
task :create_teams => :environment do
  require 'open-uri'
  require 'json'
  
  Team.all.each do |team|
    url = "https://api.steampowered.com/IDOTA2Match_570/GetTeamInfoByTeamID/V001/?start_at_team_id=#{team.id}&teams_requested=1&key=#{STEAM_KEY}"
    content = open(url).read
    output = JSON.parse(content)
    n = 0
    while output["result"]["teams"][0]["player_" + n.to_s() + "_account_id"] != nil
      id = output["result"]["teams"][0]["player_" + n.to_s() + "_account_id"]
      player = User.find_by_id(id)
      team.players << player unless player == nil
      n += 1
    end
  end
end