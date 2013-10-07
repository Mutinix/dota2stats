# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#  avatar_url :text
#

class User < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :avatar_url
  
  has_one :player_team, foreign_key: :player_id
  has_one :team, through: :player_team
  
  has_many :played_matches, foreign_key: :player_id, :class_name => "PlayerMatch"
  has_many :matches, through: :played_matches
  
  def self.steam_id_convert(from, id)
    if from == 32
      return id + 76561197960265728
    else
      return id - 76561197960265728
    end
  end
  
end
