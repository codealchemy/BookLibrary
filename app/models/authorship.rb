class Authorship < ActiveRecord::Base

  # Associations
  belongs_to :author
  belongs_to :book

  # Validations
  validates :author, presence: true
  validates :book, presence: true, uniqueness: { scope: :author }
end
