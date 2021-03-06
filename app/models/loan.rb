class Loan < ActiveRecord::Base
  DEFAULT_CHECKOUT_PERIOD = 2.weeks

  # Associations
  belongs_to :user
  belongs_to :book

  # Validations
  validates :user, :book, presence: true

  # Scopes
  scope :active, -> { where(checked_in_at: nil) }
  scope :overdue, -> { where('due_date IS NOT NULL AND due_date < ?', Date.today) }
end
