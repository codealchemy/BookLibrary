class Location < ActiveRecord::Base

  # Associations
  has_many :users
  has_many :books

  # Validations
  validates :name, presence: true
end
