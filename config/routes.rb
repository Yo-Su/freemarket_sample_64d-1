Rails.application.routes.draw do
  get 'items/index'
  root "items#index"
end
