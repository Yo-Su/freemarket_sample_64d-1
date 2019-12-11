Rails.application.routes.draw do
  root "items#index"
  resources :items, only: [:index, :show]
  resources :sell, only: [:index, :new, :create]
end
