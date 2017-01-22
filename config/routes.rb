Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/app', as: 'rails_admin'
  root 'application#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :books, only: [:index, :show] do
    post :check_out, on: :collection
    post :check_in, on: :collection
  end

  resources :users_admin, only: [:show], controller: 'users'

  resources :locations, only: [:index, :show]
end
