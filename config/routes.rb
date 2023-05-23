Rails.application.routes.draw do
  devise_for :users
  # devise_for :users, controllers: {
  #       sessions: 'users/sessions'
  #     }
  root to: "pages#home"

  resources :meetings
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :meetings
end
