Rails.application.routes.draw do

  devise_for :users, :controllers => {
      :registrations => 'users/registrations',
      :sessions => 'users/sessions'
  }

  namespace :api, format: 'json' do
    resources :login, only: %i(create), controller: :sessions
    resources :users, only: %i(create)
    resources :photographs, only: %i()
  end
  resources :home, only: %i(index new) do
    get 'photo_new', :on => :collection
    # get 'photo_new', :on => :member
  end

  root to: 'top#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
