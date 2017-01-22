Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/app', as: 'rails_admin'
  root 'application#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }

end
