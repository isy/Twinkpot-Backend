Rails.application.routes.draw do

  devise_for :users, :controllers => {
      :registrations => 'users/registrations',
      :sessions => 'users/sessions'
  }

  namespace :api, format: 'json' do
    resources :login, only: %i(create), controller: :sessions
    resources :users, only: %i(create)
    resources :photographs, only: %i() do
      get 'fetch_tags', :on => :collection
      get 'fetch_autocomplete_tags', :on => :collection
      get 'fetch_posts', :on => :collection
      get 'fetch_show_post', :on => :collection
      get 'fetch_tag_search', :on => :collection
    end
  end
  resources :home, only: %i(index new) do
    get 'tag', to: 'home#index', :on => :collection
    get 'photo_new', :on => :collection
    post 'photo_create', :on => :collection
    get 'post/:id', to: 'home#index', :on => :collection
    # get 'photo_new', :on => :member
  end

  root to: 'top#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
