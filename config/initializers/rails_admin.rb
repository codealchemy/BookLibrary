RailsAdmin.config do |config|

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    # show_in_app
  end

  ## == Model configurations ==

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

  config.model Book do
    parent Location
    field :title
    field :author_first_name
    field :author_last_name
    field :isbn
    field :description
    field :owner
  end

  config.model User do
    parent Location
    field :first_name
    field :last_name
    field :email
    field :admin
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
