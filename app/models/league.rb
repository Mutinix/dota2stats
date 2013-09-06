# == Schema Information
#
# Table name: leagues
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  url            :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  localized_name :string(255)
#

class League < ActiveRecord::Base
  attr_accessible :name, :url
  
  has_many :league_matches
  has_many :matches, through: :league_matches
end
