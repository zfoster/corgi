Corgi::Application.routes.draw do

  root "home#index"

  resources :users, only: [:show, :update] do
    collection do
      post :set_email
    end
    member do
      get :twitter_email
    end
  end

  resources :sessions, only: [:create, :destroy] do
  end

  resources :content, only: [:index] do
    collection do
      get :support
    end
  end

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match '/logout', to: 'sessions#destroy', via: [:get, :destroy]

end
