# == Schema Information
#
# Table name: match_teams
#
#  id                    :integer          not null, primary key
#  match_id              :integer
#  radiant_team_id       :integer
#  radiant_logo          :string(255)
#  dire_team_id          :integer
#  dire_logo             :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  radiant_team_complete :integer
#  dire_team_complete    :integer
#  radiant_guild_id      :integer
#  dire_guild_id         :integer
#  radiant_guild_name    :integer
#  dire_guild_name       :integer
#  radiant_guild_logo    :string(255)
#  dire_guild_logo       :string(255)
#

class MatchTeam < ActiveRecord::Base
  attr_accessible :match_id,
                  :radiant_team_id, :radiant_logo, :radiant_team_complete,
                  :radiant_guild_id, :radiant_guild_name, :radiant_guild_logo,
                  :dire_team_id, :dire_logo, :dire_team_complete,
                  :dire_guild_id, :dire_guild_name, :dire_guild_logo
  
  belongs_to :radiant_team, :class_name => "Team", foreign_key: :radiant_team_id
  belongs_to :dire_team, :class_name => "Team", foreign_key: :dire_team_id
  belongs_to :match
end
