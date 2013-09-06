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
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  devise :omniauthable, :omniauth_providers => [:steam]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :password, :password_confirmation, :remember_me,
                  :provider, :avatar_url
  
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
  
  def self.find_for_steam_oauth(auth, signed_in_resource=nil)
    uid = steam_id_convert(64, Integer(auth.uid))
    user = User.where(:id => uid).first
    if user
      user.update_attributes({name: auth.extra.raw_info.personaname,
                              avatar_url: auth.extra.raw_info.avatarfull})
    else
      user = User.new(  name:auth.extra.raw_info.personaname,
                        avatar_url: auth.extra.raw_info.avatarfull,
                        password:Devise.friendly_token[0,20]
                     )
      user.id = uid
      user.save
    end
    user
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.steam_data"] && session["devise.steam_data"]["extra"]["raw_info"]
        user.id = data["id"] if user.id.blank?
      end
    end
  end
  
end
