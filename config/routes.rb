Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/app", as: :rails_admin
  root to: redirect("/app")

  devise_for :users
end
