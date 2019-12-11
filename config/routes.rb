Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :users, only: :show do
    collection do
      get 'logout'
    end
  end
  resources :items, only: [:index, :show] do
    member do
      get 'buy'
    end
  end
  resources :sell, only: [:index, :new, :create]
end
