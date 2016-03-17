class Location < ActiveRecord::Base

  # Associations
  has_many :users
  has_many :books

  # Validations
  validates :name, presence: true

  def available_books
    books.available
  end
end
