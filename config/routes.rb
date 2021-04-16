Rails.application.routes.draw do
  root 'items#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  # get '/auth/:provider/callback', to: 'sessions#fb_login' 
  get '/auth/facebook/callback', to: 'sessions#fb_login' 
  # post '/signup', to: 'users#new'
  # get 'account', to: 'users#show'
  resources :users do
    resources :items, only: [:index, :new, :edit]
  end

  resources :items, only: [:show, :update, :destroy, :create, :new] do
    resources :bids, only: [:create]
  end

  # get '/items/new', to: 'items#new'
  # resources :items, only: [:show, :update, :destroy, :create, :new]
  resources :users, :bids

  # get "/fonts/poppins/:font", to: "sessions#fonts"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
