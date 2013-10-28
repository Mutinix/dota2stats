desc "Create new leagues"
task :create_leagues => :environment do
  require 'open-uri'
  require 'json'
  
  url = "https://api.steampowered.com/IDOTA2Match_570/GetLeagueListing/V001/?key=#{ENV['STEAM_KEY']}&language=en_us"
  content = open(url).read
  output = JSON.parse(content)

  output["result"]["leagues"].each do |league|
    # Only record entry if the details for that league have not been previously recorded
    next if League.find_by_id(league["leagueid"]) != nil
    l = League.new({name: league["name"],
                    url: league["tournament_url"],
                    description: league["description"]})
    l.id = league["leagueid"]
    l.save
  end
end