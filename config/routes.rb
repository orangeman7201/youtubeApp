Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  resources :movies, only: [:index, :show, :create]

  root to: 'home#index'

end
