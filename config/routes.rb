Rails.application.routes.draw do
  get "library/index"
  # Define the root path route ("/")
  root "welcome#index"

  # Session routes for login and logout
  resource :session, only: %i[new create destroy] do
    member do
      patch :promote_to_admin
    end
  end

  # Registration routes for new user sign-up
  resources :registrations, only: %i[new create]

  # Password routes for password management
  resources :passwords, param: :token, only: %i[new create edit update]

  # Library Resources
  resources :flashcard_sets do
    resources :flashcards, only: [ :new, :create, :edit, :update, :destroy ]
  end

  # Profile route for user profile page
  get "profile", to: "users#show", as: :profile

  # Logout route
  delete "logout", to: "sessions#destroy", as: :logout

  # Health check route
  get "up", to: "rails/health#show", as: :rails_health_check

  # Location routes
  get "home/index"
  get "welcome/index"
  get "registrations/new"
  get "registrations/create"
  get "library", to: "library#index", as: :library
end
