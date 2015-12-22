Rails.application.routes.draw do
  resources :portfolio_finances
  get 'home/index'
  devise_for :users  # The priority is based upon order of creation: first created -> highest priority.

  root 'home#index'

end
