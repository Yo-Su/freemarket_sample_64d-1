Rails.application.routes.draw do
  get 'items/index'
  root "items#show"

end
