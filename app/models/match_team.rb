class MatchTeam < ActiveRecord::Base
  attr_accessible :dire_team_id, :dire_logo, :match_id, :radiant_logo, :radiant_team_id
  
  belongs_to :radiant_team, :class_name => "Team", foreign_key: :radiant_team_id
  belongs_to :dire_team, :class_name => "Team", foreign_key: :dire_team_id
  belongs_to :match
end
