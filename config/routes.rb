Corgi::Application.routes.draw do
  root "home#index"

  resources :users, only: [:show, :update] do
    member do
      get :twitter_email
    end
  end
  resources :payments, only: [:new, :create]
  resources :contributions, only: [:create]
  resources :identities, only: [:destroy, :index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :organizations, only: [:new, :create, :show] do
    collection do
      get :autocomplete_organization_name
    end
  end
  resources :amps, only: [:new, :create]
  resources :events, only: [:new, :show, :create, :edit, :update, :index] do
    member do
      delete :cancel_registration
    end
    resources :registrations, only: [:new, :create, :index]
  end

  get '/support', to: 'content#support'
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match '/logout', to: 'sessions#destroy', via: [:get, :destroy]

end
