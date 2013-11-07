class PickBan < ActiveRecord::Base
  attr_accessible :hero_id, :is_pick, :match_id, :order, :team
end
