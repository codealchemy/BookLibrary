class Location < ActiveRecord::Base

  # Associations
  has_many :users
  has_many :books
  has_many :books_available, -> { available }, class_name: 'Book'
  has_many :books_checked_out, -> { checked_out }, class_name: 'Book'

  # Validations
  validates :name, presence: true
end
