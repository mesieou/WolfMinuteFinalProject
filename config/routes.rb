Rails.application.routes.draw do
  get 'video/screenshare'
  get 'video/name'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "pages#home"
  get "meetings/analytics", to: "meetings#analytics"
  resources :meetings do
    resources :bookings, only: [:edit, :update]
    resources :messages, only: :create
    get '/party', to: 'video#index'
    get '/screenshare', to: 'video#screenshare'
    post '/name', to: 'video#name'
  end
  resources :bookings, only: [:destroy]
  get "users/:id/card", to: "users#card", as: "user_card"
end
