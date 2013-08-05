class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  devise :omniauthable, :omniauth_providers => [:steam]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :password, :password_confirmation, :remember_me,
                  :provider, :uid
  # attr_accessible :title, :body
  
  def self.find_for_steam_oauth(auth, signed_in_resource=nil)
    user = User.where(:uid => auth.uid).first
    unless user
      user = User.create(  uid:auth.uid,
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.steam_data"] && session["devise.steam_data"]["extra"]["raw_info"]
        user.uid = data["uid"] if user.uid.blank?
      end
    end
  end
  
  
end
