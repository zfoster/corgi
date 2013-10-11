Corgi::Application.routes.draw do
  root "home#index"

  resources :users, only: [:show, :update] do
    member do
      get :set_madi_identity
      get :twitter_email
      post :update_user_data
    end
  end
  resources :registrations, only: [:destroy]
  resources :contributions, only: [:create]
  resources :identities, only: [:destroy]
  resources :sessions, only: [:create, :destroy]
  resources :content, only: [:index] do
    collection do
      get :support
    end
  end
  resources :events , only: [:new, :show, :create, :edit, :update, :index] do
  end

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match '/logout', to: 'sessions#destroy', via: [:get, :destroy]

end
