class AbilityUpgrade < ActiveRecord::Base
  attr_accessible :ability_id, :level, :player_match_id, :time
end
