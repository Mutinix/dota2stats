# == Schema Information
#
# Table name: match_teams
#
#  id              :integer          not null, primary key
#  match_id        :integer
#  radiant_team_id :integer
#  radiant_logo    :string(255)
#  dire_team_id    :integer
#  dire_logo       :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class MatchTeam < ActiveRecord::Base
  attr_accessible :dire_team_id, :dire_logo, :match_id, :radiant_logo, :radiant_team_id
  
  belongs_to :radiant_team, :class_name => "Team", foreign_key: :radiant_team_id
  belongs_to :dire_team, :class_name => "Team", foreign_key: :dire_team_id
  belongs_to :match
end
