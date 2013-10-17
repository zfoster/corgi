Corgi::Application.routes.draw do
  root "home#index"

  resources :users, only: [:show, :update] do
    member do
      get :twitter_email
    end
  end
  resources :registrations, only: [:destroy]
  resources :contributions, only: [:create]
  resources :identities, only: [:destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :events, only: [:new, :show, :create, :edit, :update, :index] do
    member do
      get :attendees_csv
    end
  end
  resources :registrations, only: [:create] do
    member do
      delete :cancel_registration
    end
  end

  get '/support', to: 'content#support'
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match '/logout', to: 'sessions#destroy', via: [:get, :destroy]

end
