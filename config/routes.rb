Rails.application.routes.draw do
  get 'rooms/index'
  root 'home#index'
  
  get '/contact', to: 'contact#index', as: :contact

  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create, :show], path: 'register', path_names: { new: '/'}
    resources :sessions, only: [:new, :create, :destroy], path: 'login', path_names: { new: '/' }
    resources :admin, only: [:index], path: 'admin', as: 'admin'
  end
  
  resources :types, except: :show
  resources :cars
  resources :reservations
  
  resources :rooms do
    resources :messages
  end

  get 'password/reset', to: 'password_resets#new'
  post 'password/reset', to: 'password_resets#create'
  get 'password/reset/edit', to: 'password_resets#edit'
  patch 'password/reset/edit', to: 'password_resets#update'


end