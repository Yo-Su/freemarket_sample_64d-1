Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :users, only: :show do
    collection do
      get 'logout'
    end
  end
  resources :items, only: :show do
    member do
      get 'buy'
    end
  end
  resources :signup, only: :create do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      get 'step4'
      get 'step5' # ここで、入力の全てが終了する
      get 'done' # 登録完了後のページ
end
