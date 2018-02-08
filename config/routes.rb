Rails.application.routes.draw do

  devise_for :users, :controllers => {
      :registrations => 'users/registrations',
      :sessions => 'users/sessions'
  }

  namespace :api, format: 'json' do
    resources :login, only: %i(create), controller: :sessions
    resources :users, only: %i(create)
    resources :photographs, only: %i() do
      get 'fetch_tags', on: :collection
      get 'fetch_popular_tag', on: :collection
      get 'fetch_autocomplete_tags', on: :collection
      get 'fetch_category', on: :collection
      get 'fetch_city', on: :collection
      get 'fetch_refine_posts', on: :collection
      get 'fetch_posts', on: :collection
      get 'fetch_limit_posts', on: :collection
      get 'fetch_user_rank', on: :collection
      get 'fetch_popular_posts', on: :collection
      get 'fetch_show_post', on: :collection
      get 'fetch_tag_search', on: :collection
      get 'fetch_place_post', on: :collection
      post 'post_like', on: :collection
      delete 'delete_like', on: :collection
    end
    resources :itineraries, only: %i() do
      get 'fetch_itineraries', on: :collection
      post 'post_itineraries', on: :collection
      post 'post_itinerary_details', on: :collection
      get 'fetch_itinerary_lists', on: :collection
      get 'fetch_itinerary_details', on: :collection
      get 'fetch_itinerary_places', on: :collection
      delete 'delete_itinerary_detail', on: :collection
    end
  end

  resources :users, param: :user_name, only: %i(show edit update) do
    get 'itinerary', on: :member
    get 'itinerary/:id', to: 'users#itinerary', on: :member
    get 'itinerary/:id/edit', to: 'users#itinerary', on: :member
  end
  resources :home, only: %i(index new) do
    get 'tag', to: 'home#index', on: :collection
    get 'tag/:name', to: 'home#index', on: :collection
    get 'all', to: 'home#index', on: :collection
    get 'photo_new', on: :collection
    post 'photo_create', on: :collection
    get 'post/:id', to: 'home#index', on: :collection
    get 'place/:name', to: 'home#index', on: :collection
    # get 'photo_new', :on => :member
  end

  root to: 'top#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
