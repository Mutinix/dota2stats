class PickBan < ActiveRecord::Base
  attr_accessible :hero_id, :is_pick, :match_id, :order, :team
  
  belongs_to :match
  belongs_to :hero
end
