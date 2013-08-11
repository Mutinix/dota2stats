class Scrim < ActiveRecord::Base
  attr_accessible :match_time, :team1_id, :team2_id, :server
  
  belongs_to :requester, foreign_key: :team1_id, :class_name => "Team"
  belongs_to :requestee, foreign_key: :team2_id, :class_name => "Team"
end
