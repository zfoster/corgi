Corgi::Application.routes.draw do

  get "sessions/create"
  get "sessions/destroy"
  root "home#index"

  resources :users, only: [:show]

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match '/logout', to: 'sessions#destroy', via: [:get, :destroy]

end
