# == Schema Information
#
# Table name: league_matches
#
#  id         :integer          not null, primary key
#  league_id  :integer
#  match_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LeagueMatch < ActiveRecord::Base
  attr_accessible :league_id, :match_id
  
  belongs_to :league
  belongs_to :match
  
end
