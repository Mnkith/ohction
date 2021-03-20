Rails.application.routes.draw do
  resources :users
  resources :sessions
  get "/signup", to: "sessions#signup"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
