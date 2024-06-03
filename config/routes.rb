Rails.application.routes.draw do
  devise_for :users
  root to: "workspaces#index"
  resources :users, only: :show
  namespace :api do
    resources :workspaces, only: [:index, :create, :show]
  end
end
