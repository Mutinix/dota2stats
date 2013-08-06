class PlayerTeam < ActiveRecord::Base
  attr_accessible :player_id, :team_id
  
  belongs_to :user, foreign_key: :player_id
  belongs_to :team
end
