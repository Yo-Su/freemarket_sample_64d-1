Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :users, only: :show do
    collection do
      get 'logout'
    end
  end
  resources :items, only: [:index, :show,:new, :create] do
    member do
      get 'buy'
      post 'pay'
      get 'checkout'
    end
  end
  resources :sell, only: [:index, :new, :create]
  resources :card, only: [:index, :create, :new, :destroy]
  resources :imeges, only: [:new, :create]

end
