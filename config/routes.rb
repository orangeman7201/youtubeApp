Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  root to: 'home#index'

  resources :movies, only: [:index, :show, :create]
  resources :users
  resources :sessions

  post "sessions/logout", to: "sessions#destroy"
  post "requests", to: "requests#serch"
  post "requests/create", to: "requests#create"

end
