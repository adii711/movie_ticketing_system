Rails.application.routes.draw do
  resources :tickets
  resources :shows
  resources :movies do
    resources :shows, only: [:index] # Nesting shows under movies
  end
  resources :admins, only: [:edit, :update]
  root 'home#index'
  resources :users
  resources :admin_sessions, only: [:new, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: "users#new", as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'
  get 'admin_login', to: "admin_sessions#new", as: 'admin_login'
  get 'admin_logout', to: "admin_sessions#destroy", as: 'admin_logout'
end
