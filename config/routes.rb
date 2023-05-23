Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "pages#home"
  resources :meetings do
    resources :bookings, only: [:edit, :update]
  end
  resources :bookings, only: [:destroy]
  resources :users, only: [:show]
end
