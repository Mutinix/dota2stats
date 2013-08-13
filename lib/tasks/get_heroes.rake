desc "Get all the heroes"
task :get_heroes => :environment do
  require 'open-uri'
  require 'json'
  
  url = "http://api.steampowered.com/IEconDOTA2_570/GetHeroes/V001/?key=#{STEAM_KEY}&language=en_us"
  content = open(url).read
  content = JSON.parse(content)
  
  content["result"]["heroes"].each do |hero|
    next if Hero.find_by_id(hero["id"]) != nil
    h = Hero.new({ name: hero["name"],
                   localized_name: hero["localized_name"],
                   image_url: "http://media.steampowered.com/apps/dota2/images/heroes/#{hero['name'][14..-1]}_full.png",
                   thumb_url: "http://media.steampowered.com/apps/dota2/images/heroes/#{hero['name'][14..-1]}_sb.png"})
    h.id = hero["id"]
    h.save
  end
  
end