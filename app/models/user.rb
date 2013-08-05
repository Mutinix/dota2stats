class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :password, :password_confirmation, :remember_me,
                  :provider, :uid
  # attr_accessible :title, :body
  
  def self.find_for_steam_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.personaname,
                           provider:auth.provider,
                           uid:auth.uid,
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end
  
  
end
