class Match < ActiveRecord::Base
  attr_accessible :duration, :game_mode, :radiant_win
  
  has_many :player_match
  has_many :players, through: :player_match, source: :user
end
