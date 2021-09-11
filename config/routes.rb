Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  resources :movies, only: [:index, :show]

  root to: 'home#index'

end
