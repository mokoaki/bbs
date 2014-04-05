Bbs::Application.routes.draw do
  root 'users#index'

  resources :sessions, only: [:create]
  resources :users, only: [:edit, :update]
  resources :plates, only: [:show, :create]
  resources :bbs_threads, only: [:show]
  resources :contexts, only: [:show, :create] do
    member do
      post :recontexts
    end
  end

  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
end
