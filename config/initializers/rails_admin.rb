Dir["#{Rails.root}/lib/rails_admin/*.rb"].each { |file| require file }

RailsAdmin.config do |config|

  config.main_app_name = ['Library', '']
  config.parent_controller = '::ApplicationController'

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
  config.authorize_with(:cancancan)

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    show
    edit
    new         { authorization_key :admin }
    export      { authorization_key :admin }
    delete      { authorization_key :admin }
    bulk_delete { authorization_key :admin }
    checkout    { only %w(Book) }
    check_in    { only %w(Book) }
  end

  ## == Model configurations ==
  config.excluded_models << Authorship

  config.model Location do
    admin_only
    weight(-1)
    field :name
    field :users
    field :books_available
    field :books_checked_out
    edit do
      field :books
      field :address1
      field :address2
      field :city
      field :state
      field :zip
      field :country
      exclude_fields :books_available,
                     :books_checked_out
    end
  end

  config.model Author do
    admin_only
    field :first_name
    field :last_name
    field :books
  end

  config.model Book do
    field :title
    field :authors
    field :location
    field :description
    show do
      field :owner
      field :isbn
    end
    list { scopes [:available, :checked_out] }
  end

  config.model User do
    admin_only
    field :first_name
    field :last_name
    field :email
    field :location
    show do
      field :admin
      field :books_borrowed
      field :books_owned
    end
    edit do
      field :password
    end
  end

  config.model Loan do
    admin_only
    parent User
    field :user
    field :book
    field :checked_out_at
    field :checked_in_at
    field :due_date
    list { scopes [nil, :active, :overdue] }
  end

  private

  def admin_only
    visible { bindings[:controller]._current_user.admin? }
  end
end
