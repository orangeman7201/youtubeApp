Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  resources :movies, only: [:index, :show]

end
