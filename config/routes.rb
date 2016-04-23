Rails.application.routes.draw do

  authenticated :user, -> (user) { user.admin? } { mount RailsAdmin::Engine => '/admin', as: 'rails_admin' }
  root 'books#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :books, only: [:index, :show] do
    post :check_out, on: :collection
    post :check_in, on: :collection
    patch :check_out_on_behalf_of, on: :member
    post :check_in_on_behalf_of, on: :member
  end

  resources :users_admin, controller: 'users' do
    post :make_admin, on: :collection
    post :remove_admin, on: :collection
  end

  resources :locations, only: [:index, :show]
end
