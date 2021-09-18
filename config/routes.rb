Rails.application.routes.draw do

  devise_for :users
  ActiveAdmin.routes(self)
  resources :movies, only: [:index, :show, :create]

  root to: 'home#index'

end
