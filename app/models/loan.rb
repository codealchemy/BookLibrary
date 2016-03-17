class Loan < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :book

  # Validations
  validates :user, :book, presence: true

  # Scopes
  scope :active, -> { where(checked_in_at: nil) }
end
