# == Schema Information
#
# Table name: matches
#
#  radiant_win             :boolean
#  duration                :integer
#  game_mode               :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  match_seq_num           :integer
#  start_time              :integer
#  lobby_type              :integer
#  tower_status_radiant    :integer
#  tower_status_dire       :integer
#  barracks_status_radiant :integer
#  barracks_status_dire    :integer
#  cluster                 :integer
#  first_blood_time        :integer
#  human_players           :integer
#  positive_votes          :integer
#  negative_votes          :integer
#  leagueid                :integer
#  id                      :integer          not null, primary key
#

class Match < ActiveRecord::Base
  attr_accessible :duration, :game_mode, :radiant_win, :match_seq_num,
                  :start_time, :lobby_type, :tower_status_radiant,
                  :tower_status_dire, :barracks_status_radiant,
                  :barracks_status_dire, :cluster, :first_blood_time,
                  :human_players, :positive_votes, :negative_votes, :league_id
  
  has_many :player_matches, dependent: :destroy
  has_many :players, through: :player_matches, source: :user
  
  belongs_to :league
  
  has_one :radiant_team, :class_name => "MatchTeam", foreign_key: :radiant_team_id
  has_one :dire_team, :class_name => "MatchTeam", foreign_key: :dire_team_id
  
end
