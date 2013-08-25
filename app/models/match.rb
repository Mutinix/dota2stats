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
  attr_accessible :duration, :game_mode, :radiant_win, :match_seq_num
  
  has_many :player_matches, dependent: :destroy
  has_many :players, through: :player_matches, source: :user
  
  has_one :match_league
  has_one :league, through: :match_league
  
  has_one :match_team
  has_one :radiant_team, through: :match_team, foreign_key: :radiant_team_id
  has_one :dire_team, through: :match_team, foreign_key: :dire_team_id
  
end
