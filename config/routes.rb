DotaNexus::Application.routes.draw do
  
  devise_for :users, :controllers => {
                        :omniauth_callbacks => "users/omniauth_callbacks" }
                        
  devise_scope :user do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  
  resources :teams, only: [:show]
  resources :users, only: [:show]
  resources :matches, only: [:show]
  resources :leagues, only: [:index, :show] do
    resources :matches, only: [:index]
  end
  
  get '/roster', to: 'teams#show', as: :roster
  
  resources :scrims, only: [:create]
  
end
