# == Schema Information
#
# Table name: abilities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Ability < ActiveRecord::Base
  attr_accessible :name
  
  has_many :ability_upgrades
end
