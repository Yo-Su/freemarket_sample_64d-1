Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  get 'users/logout', to: "users#logout"
  resources :users, only: :show
  resources :items, only: :show
end
