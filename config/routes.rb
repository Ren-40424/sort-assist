Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "workspaces#index"
  resources :users, only: [:show, :destroy] do
    collection do
      get 'search'
    end
  end
  namespace :api do
    resources :sessions, only: :show
    resources :workspaces, only: [:index, :create, :show, :update, :destroy] do
      collection do
        post 'add_user'
      end
    end
    resources :users, only: :index
    resources :sheets, only: [:index, :create, :show, :update, :destroy]
    resources :courses, only: [:index, :create, :update] do
      member do
        patch 'update_create_load_sheet'
      end
    end
    resources :addresses, only: [:index, :create, :update]
    resources :roles, only: :index
  end
  get '*path', to: 'workspaces#index', constraints: ->(req) { req.format.html? }
end
