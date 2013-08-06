class Team < ActiveRecord::Base
  attr_accessible :country_code, :name, :tag, :url
  
  has_many :player_team
  has_many :players, through: :player_team, source: :user
end
