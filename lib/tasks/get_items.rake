desc "Get all the items"
task :get_items => :environment do
  require 'open-uri'
  require 'json'
  
  url = "http://www.dota2.com/jsfeed/itemdata"
  content = open(url).read
  output = JSON.parse(content)
  
  output["itemdata"].each do |item|
    i = Item.new({
      name: item[0],
      image_url: "http://media.steampowered.com/apps/dota2/images/items/#{item[1]['img']}"
    })
    i.id = item[1]['id']
    i.save
  end
  
end