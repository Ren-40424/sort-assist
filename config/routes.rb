Rails.application.routes.draw do
  devise_for :users
  root to: "workspaces#index"
  resources :users, only: [:show, :destroy] do
    collection do
      get 'search'
    end
  end
  namespace :api do
    resources :workspaces, only: [:index, :create, :show] do
      collection do
        post 'add_user'
      end
    end
    resources :users, only: :index
    resources :sheets, only: [:index, :create, :show]
    resources :courses, only: [:index, :create]
    resources :addresses, only: [:index, :create, :update]
    resources :roles, only: :index
  end
end
