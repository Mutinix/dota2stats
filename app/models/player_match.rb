class PlayerMatch < ActiveRecord::Base
  attr_accessible :assists, :deaths, :denies, :gold, :gold_per_min, :gold_spent, :hero_id, :item_0, :item_1, :item_2, :item_3, :item_4, :item_5, :kills, :last_hits, :level, :match_id, :player_id, :player_slot, :xp_per_min
  
  belongs_to :user, foreign_key: :player_id
  belongs_to :match
end
