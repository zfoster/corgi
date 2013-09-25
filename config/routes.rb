Corgi::Application.routes.draw do

  get "sessions/create"
  get "sessions/destroy"
  get '/support' => 'content#support', :as => :support
  root "home#index"

  resources :users, only: [:show, :update] do
    member do
      get :twitter_email
      post '/set_default_avatar' => 'users#set_default_avatar'
    end

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match '/logout', to: 'sessions#destroy', via: [:get, :destroy]

end
