Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  patch "/friends/:id", to: 'user#accept_friend', as: 'accept_friend'
  post "/friends/:id", to: 'user#add_friend', as: 'add_friend'
  get 'be-requesteds', to: 'user#be_requesteds', as: 'be_requesteds'
  get 'be-requesteds-1', to: 'user#be_requesteds_1', as: 'be_requesteds_1'
  get 'requestings', to: 'user#requestings', as: 'requestings'
  get 'availables', to: 'user#availables', as: 'availables'
  delete "/be-requesteds/:id", to: 'friendship#un_accept', as: 'un_accept'
  delete "/requestings/:id", to: 'friendship#destroy_request', as: 'destroy_request'
  delete "/friends/:id", to: 'friendship#destroy', as: 'friendship'
  get '/friends/:id', to: 'user#show', as: 'user'
  get '/friends', to: 'user#friends'
  devise_for :users
  # resources :friends  
  get 'home/about', to: 'home#about'
  root 'user#friends'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
