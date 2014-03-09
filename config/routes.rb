DotaNexus::Application.routes.draw do
  
  
  
  ComfortableMexicanSofa::Routing.admin(:path => '/cms-admin')
  
  # Make sure this routeset is defined last
  ComfortableMexicanSofa::Routing.content(:path => '/', :sitemap => false)

  root to: "static_pages#splash"
  post 'auth/steam/callback' => 'users#auth_callback'
  
  resources :teams, only: [:show]
  resources :users, only: [:show]
  resources :matches, only: [:show]
  resources :leagues, only: [:index, :show] do
    resources :matches, only: [:index]
  end
  
  get '/roster', to: 'teams#show', as: :roster
  
  resources :scrims, only: [:create]
  
end
