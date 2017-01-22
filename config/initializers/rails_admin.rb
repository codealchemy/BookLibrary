RailsAdmin.config do |config|

  config.main_app_name = ['Library', '']
  config.parent_controller = '::ApplicationController'

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
  config.authorize_with(:cancan)

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    show
    new         { authorization_key :admin }
    edit        { authorization_key :admin }
    export      { authorization_key :admin }
    delete      { authorization_key :admin }
    bulk_delete { authorization_key :admin }
  end

  ## == Model configurations ==

  config.excluded_models << Authorship

  config.model Location do
    field :name
    field :address1
    field :address2
    field :city
    field :state
    field :zip
    field :country
    field :users
    field :books
  end

  config.model Author do
    parent Location
    field :first_name
    field :last_name
    field :books
  end

  config.model Book do
    parent Location
    field :title
    field :authors
    field :isbn
    field :description
    field :owner
    list { scopes [nil, :checked_out, :available] }
  end

  config.model User do
    parent Location
    field :first_name
    field :last_name
    field :email
    field :admin
    field :password
    field :location
    field :books_borrowed
    field :books_owned
  end

  config.model Loan do
    parent User
    field :user
    field :book
    field :checked_out_at
    field :checked_in_at
    field :due_date
    list { scopes [nil, :active, :overdue] }
  end
end
