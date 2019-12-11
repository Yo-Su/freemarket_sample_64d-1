Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :users, only: :show
  resources :items,  only: [:new, :create]
  resources :imeges, only: [:new, :create]
end
