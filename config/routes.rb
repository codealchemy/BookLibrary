Rails.application.routes.draw do

  root "books#index"

  devise_for :users, controllers: { sessions: 'users/sessions' }  
  
  resources :books do
    post :check_out, on: :collection
    post :check_in, on: :collection
  end

  resources :users_admin, controller: 'users' do
    post :make_admin, on: :collection
    post :remove_admin, on: :collection
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

end
