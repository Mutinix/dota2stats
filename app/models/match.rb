# == Schema Information
#
# Table name: matches
#
#  id          :integer          not null, primary key
#  radiant_win :boolean
#  duration    :integer
#  game_mode   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Match < ActiveRecord::Base
  attr_accessible :duration, :game_mode, :radiant_win
  
  has_many :player_matches
  has_many :players, through: :player_matches, source: :user
end
