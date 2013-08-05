DotaNexus::Application.routes.draw do
  
  root to: "sessions#new"
  
  devise_for :users, :controllers => {
                        :omniauth_callbacks => "users/omniauth_callbacks" }
                        
  devise_scope :user do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  
  resource :session, only: [:new]
  
  
end
