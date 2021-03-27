Rails.application.routes.draw do
  root "items#index" 
  get "/signup", to: "sessions#signup"
  resources :users, :items
  # get "/signup", to: "users#new"

  # get "/fonts/poppins/:font", to: "sessions#fonts"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
