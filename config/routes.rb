Bbs::Application.routes.draw do
  root 'users#index'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :plates, only: [:show]
  resources :bbs_threads, only: [:show]
  resources :contexts, only: [:show, :create]

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
end
