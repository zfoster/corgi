Corgi::Application.routes.draw do
  resources :shares

  resources :events do
    member do
      get :new_member
    end
  end

  root "home#index"

  resources :users, only: [:show, :update] do
    member do
      get :set_madi_identity
      get :twitter_email
      get :set_mobile_num
    end
  end
  resources :contributions, only: [:create]
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
