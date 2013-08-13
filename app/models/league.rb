# == Schema Information
#
# Table name: leagues
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  url        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class League < ActiveRecord::Base
  attr_accessible :name, :url
end
