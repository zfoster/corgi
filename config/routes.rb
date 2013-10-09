Corgi::Application.routes.draw do
  resources :organizations

  resources :venues

  resources :shares

  resources :events do
    get :attendee_csv
    member do
      get :new_attendee
      get :close_registration
    end
  end

  root "home#index"

  resources :users, only: [:show, :update] do
    member do
      get :set_madi_identity
      get :twitter_email
      post :update_user_data
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
