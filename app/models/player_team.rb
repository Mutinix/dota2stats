# == Schema Information
#
# Table name: player_teams
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PlayerTeam < ActiveRecord::Base
  attr_accessible :player_id, :team_id
  
  belongs_to :user, foreign_key: :player_id
  belongs_to :team
end
