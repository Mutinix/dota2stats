class AbilityUpgrade < ActiveRecord::Base
  attr_accessible :ability_id, :level, :player_match_id, :time
  
  belongs_to :player_match
  belongs_to :ability
end
