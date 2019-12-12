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

  resources :signup, only: :create do
    collection do
      get 'member_info'
      get 'phone_info'
      get 'sms_confirmation'
      get 'address_info'
      get 'credit_info' # ここで、入力の全てが終了する
      get 'complete' # 登録完了後のページ
    end
  end

  resources :sell, only: [:index, :new, :create]
  resources :cards, only: [:index, :create, :new, :destroy]
  resources :imeges, only: [:new, :create]

end
