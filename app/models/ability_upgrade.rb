# == Schema Information
#
# Table name: ability_upgrades
#
#  id              :integer          not null, primary key
#  ability_id      :integer
#  time            :integer
#  level           :integer
#  player_match_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class AbilityUpgrade < ActiveRecord::Base
  attr_accessible :ability_id, :level, :player_match_id, :time
  
  belongs_to :player_match
  belongs_to :ability
end
