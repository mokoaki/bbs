Bbs::Application.routes.draw do
  root 'users#index'

  resources :sessions, only: [:create]
  resources :users, only: [:edit, :update]

  resources :plates, only: [:show, :create, :destroy]
  patch 'plates/update', to: 'plates#update'

  resources :bbs_threads, only: [:show, :create, :destroy]
  patch 'bbs_threads/update', to: 'bbs_threads#update'

  resources :contexts, only: [:show, :create] do
    member do
      post :recontexts
    end
  end

  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
end
