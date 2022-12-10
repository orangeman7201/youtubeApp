Rails.application.routes.draw do

  devise_for :users
  ActiveAdmin.routes(self)
  root to: 'home#index'

  resources :movies, only: [:create]
  resources :users do
    member do
      put 'update_image'
    end
  end
  resources :sessions
  resources :friends
  resources :durations, only: [:index]
  resources :posts, only: [:index, :create, :update]
  resources :replies, only: [:create] 

  post "sessions/logout", to: "sessions#destroy"
  post "sign_up", to: "users#create"
  get "session_check", to: "sessions#session_check"
  post "gest/login", to: "sessions#gest_login"
  post "requests/serch", to: "requests#serch"
  get "requests", to: "requests#index"
  post "requests/create", to: "requests#create"
  post "requests/destroy", to: "requests#destroy"
  get "self", to: "users#self"
  get "weekly_duration_sum", to: "durations#weekly_duration_sum"

  ## vue router でエラーを呼ばないための記述
  get  '*unmatched_route', to: 'home#index'
end
