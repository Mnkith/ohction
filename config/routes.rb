Rails.application.routes.draw do
  root 'items#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  # post '/signup', to: 'users#new'
  # get 'account', to: 'users#show'
  resources :users do
    resources :items, only: [:index, :new]
  end

  resources :items do
    resources :bids, only: [:create]
  end

  # get '/items/new', to: 'items#new'
  resources :items, only: [:show, :edit, :update, :destroy, :create, :new]
  resources :users, :bids

  # get "/fonts/poppins/:font", to: "sessions#fonts"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
