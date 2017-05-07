Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/dashboard", as: :rails_admin
  root to: redirect("/dashboard")

  devise_for :users
end
