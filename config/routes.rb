Rails.application.routes.draw do
  devise_for :users
  root to: "workspaces#index"
  resources :users, only: :show do
    resources :workspaces, only: :create
  end
end
