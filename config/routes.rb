Rails.application.routes.draw do
  get '/home', to: 'home#index'

  devise_for :users, only: []

  namespace :api, format: 'json' do
    resources :login, only: %i(create), controller: :sessions
    resources :users, only: %i(create)
  end
  root to: 'top#index'

  get 'top/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
