Rails.application.routes.draw do
  get 'home/index'

  devise_for :users
  root to: 'top#index'

  get 'top/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
