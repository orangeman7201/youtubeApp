Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  root to: 'home#index'

  resources :movies, only: [:index, :show, :create]
  resources :users
  resources :sessions
  resources :friends

  post "sessions/logout", to: "sessions#destroy"
  post "requests", to: "requests#serch"
  get "requests", to: "requests#index"
  post "requests/create", to: "requests#create"
  post "requests/destroy", to: "requests#destroy"

end
