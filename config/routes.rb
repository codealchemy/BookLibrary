Rails.application.routes.draw do
  require 'resque/server'
  
  root 'books#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :books do
    post :check_out, on: :collection
    post :check_in, on: :collection
  end

  resources :users_admin, controller: 'users' do
    post :make_admin, on: :collection
    post :remove_admin, on: :collection
  end

  mount Resque::Server.new, at: "/resque"

end
