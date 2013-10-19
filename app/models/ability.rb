class Ability < ActiveRecord::Base
  attr_accessible :name
  
  has_many :ability_upgrades
end
