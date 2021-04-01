Rails.application.routes.draw do
  root 'items#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  # get 'account', to: 'users#show'
  resources :users do
    resources :items, only: [:index, :new, :create]
  end
  resources :items, only: [:show, :edit, :update, :destroy]
  resources :users, :items

  # get "/fonts/poppins/:font", to: "sessions#fonts"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
