Corgi::Application.routes.draw do
  root "home#index"

  resources :users, only: [:show, :update] do
    member do
      get :twitter_email
      post '/set_default_avatar' => 'users#set_default_avatar'
    end
  end
  resources :identities, only: [:destroy]
  resources :sessions, only: [:create, :destroy]
  resources :content, only: [:index] do
    collection do
      get :support
    end
  end

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match '/logout', to: 'sessions#destroy', via: [:get, :destroy]

end
