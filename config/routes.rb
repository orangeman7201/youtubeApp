Rails.application.routes.draw do

  devise_for :users
  ActiveAdmin.routes(self)
  root to: 'home#index'

  resources :movies
  resources :users
  resources :sessions
  resources :friends

  post "sessions/logout", to: "sessions#destroy"
  get "session_check", to: "sessions#session_check"
  post "gest/login", to: "sessions#gest_login"
  post "requests", to: "requests#serch"
  get "requests", to: "requests#index"
  post "requests/create", to: "requests#create"
  post "requests/destroy", to: "requests#destroy"
  post "users/self", to: "users#self"
end
