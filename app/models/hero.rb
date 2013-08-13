# == Schema Information
#
# Table name: heros
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  image_url      :text
#  localized_name :string(255)
#  thumb_url      :text
#

class Hero < ActiveRecord::Base
  attr_accessible :name, :localized_name, :image_url, :thumb_url
  
  has_many :player_matches
end
