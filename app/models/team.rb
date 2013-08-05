class Team < ActiveRecord::Base
  attr_accessible :country_code, :name, :tag, :url
end
