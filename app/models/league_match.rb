class LeagueMatch < ActiveRecord::Base
  attr_accessible :league_id, :match_id
  
  belongs_to :league
  belongs_to :match
  
end
