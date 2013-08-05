class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def steam
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_steam_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Steam") if is_navigational_format?
    else
      session["devise.steam_data"] = request.env["omniauth.auth"]
      render "Done!"
      #redirect_to new_user_registration_url
    end
  end
end