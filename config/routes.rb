Bbs::Application.routes.draw do
  root 'plates#index'

  resources :sessions, only: [:create]

  resources :users, only: [:edit, :update, :index] do
    collection do
      post :search
      post :plate_access
    end
  end

  resources :plates, only: [:show, :create, :destroy]
  patch 'plates/update', to: 'plates#update'

  resources :bbs_threads, only: [:show, :create, :destroy]
  patch 'bbs_threads/update', to: 'bbs_threads#update'

  resources :contexts, only: [:show, :create, :destroy] do
    member do
      post :recontexts
    end
  end

  get    '/signin',  to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
end
