# == Schema Information
#
# Table name: additional_units
#
#  id              :integer          not null, primary key
#  unitname        :string(255)
#  item_0          :integer
#  item_1          :integer
#  item_2          :integer
#  item_3          :integer
#  item_4          :integer
#  item_5          :integer
#  player_match_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class AdditionalUnit < ActiveRecord::Base
  attr_accessible :item_0, :item_1, :item_2, :item_3, :item_4, :item_5,
  :player_match_id, :unitname
  
  belongs_to :player_match
end
