desc "Create new leagues"
task :create_leagues => :environment do
  require 'open-uri'
  require 'json'
  
  last_league_id = -1
  
  while last_league_id != (League.last ? League.last.id : 0)
    last_league_id = (League.last ? League.last.id : 0)
    url = "https://api.steampowered.com/IDOTA2Match_570/GetLeagueListing/V001/?key=#{STEAM_KEY}"
    content = open(url).read
    output = JSON.parse(content)

    output["result"]["leagues"].each do |league|
      next if League.find_by_id(league["leagueid"]) != nil
      l = League.new({name: league["name"], url: league["tournament_url"]})
      l.id = league["leagueid"]
      l.save
    end
  end
end