Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    # GET /about
    get "about", to: "about#index"
    # Defines the root path route ("/")
    root "main#index"
  
    get "sign_up", to: "registration#new"
    post "sign_up", to: "registration#create"
end
