# == Schema Information
#
# Table name: pick_bans
#
#  id         :integer          not null, primary key
#  is_pick    :boolean
#  hero_id    :integer
#  team       :integer
#  order      :integer
#  match_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PickBan < ActiveRecord::Base
  attr_accessible :hero_id, :is_pick, :match_id, :order, :team
  
  belongs_to :match
  belongs_to :hero
end
