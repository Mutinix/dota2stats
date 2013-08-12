require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

desc "Create team rosters"
task :create_teams => :environment do
  require 'open-uri'
  require 'json'
  
  team_id = 
  
  Team.all.each do |team|
    url = "https://api.steampowered.com/IDOTA2Match_570/GetTeamInfoByTeamID/V001/?start_at_team_id=#{team.id}&teams_requested=1&key=#{STEAM_KEY}"
    content = open(url).read
    output = JSON.parse(content)
    n = 0
    while output["result"]["teams"]["player_" + n + "_account_id"] != ""
      uid = output["result"]["teams"]["player_" + n + "_account_id"]
      uid = SteamIDConvert(32, uid)
      player = User.find_by_uid(uid)
      Team.players << player
    end
  end
end