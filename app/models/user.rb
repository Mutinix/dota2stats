# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  avatar_url             :text
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
