Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  root to: 'home#index'
  
  resources :movies, only: [:index, :show, :create]
  resources :users


end
