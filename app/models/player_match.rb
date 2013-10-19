# == Schema Information
#
# Table name: player_matches
#
#  id           :integer          not null, primary key
#  match_id     :integer
#  player_id    :integer
#  player_slot  :integer
#  hero_id      :integer
#  item_0       :integer
#  item_1       :integer
#  item_2       :integer
#  item_3       :integer
#  item_4       :integer
#  item_5       :integer
#  kills        :integer
#  deaths       :integer
#  assists      :integer
#  gold         :integer
#  last_hits    :integer
#  denies       :integer
#  gold_per_min :integer
#  xp_per_min   :integer
#  gold_spent   :integer
#  level        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PlayerMatch < ActiveRecord::Base
  attr_accessible :assists, :deaths, :denies, :gold, :gold_per_min, :gold_spent, :hero_id, :item_0, :item_1, :item_2, :item_3, :item_4, :item_5, :kills, :last_hits, :level, :match_id, :player_id, :player_slot, :xp_per_min
  
  belongs_to :user, foreign_key: :player_id
  belongs_to :match
  
  belongs_to :hero
  
  has_many :ability_upgrades
  
  def is_radiant?
    self.player_slot < 128
  end
  
  def is_winner?
    self.is_radiant? == self.match.radiant_win
  end
  
end
