DotaNexus::Application.routes.draw do
  
  
  root to: "static_pages#splash"
  
  resources :teams, only: [:show]
  resources :users, only: [:show]
  resources :matches, only: [:show]
  resources :leagues, only: [:index, :show] do
    resources :matches, only: [:index]
  end
  
  get '/roster', to: 'teams#show', as: :roster
  
  resources :scrims, only: [:create]
  
end
