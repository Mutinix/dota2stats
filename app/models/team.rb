class Team < ActiveRecord::Base
  attr_accessible :country_code, :name, :tag, :url
  
  has_many :player_team
  has_many :players, through: :player_team, source: :user
  
  has_many :requests, foreign_key: :team2_id, :class_name => "Scrim"
  has_many :challenges, foreign_key: :team1_id, :class_name => "Scrim"

  has_many :requesters, through: :requests, :class_name => "Team",
  foreign_key: :team2_id, source: :requester
  has_many :challenged_teams, through: :challenges, :class_name => "Team",
  foreign_key: :team1_id, source: :requestee

end
