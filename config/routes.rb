Rails.application.routes.draw do
  devise_for :users
  root to: "workspaces#index"
  resources :users, only: :show do
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
  end
end
