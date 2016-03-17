class Book < ActiveRecord::Base
  searchkick

  # Associations
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  belongs_to :location
  has_many :loans, dependent: :destroy
  has_many :borrowers, class_name: 'Loan', foreign_key: :book_id

  # Validations
  validates :title, :isbn, presence: true

  # Scopes
  scope :checked_out, -> { joins(:loans).merge(Loan.active) }
  scope :available, -> { eager_load(:loans).where('loans.book_id IS NULL OR loans.checked_in_at < ?', Time.now) }

  before_save do
    self.isbn = self.isbn.to_s.gsub(/\D/, '')
  end

  def author_name
    "#{author_first_name} #{author_last_name}".strip
  end

  def borrowed?
    loans.active.where(book: self).present?
  end

  def borrower
    loans.active.where(book: self).last.user if borrowed?
  end

  def search_data
    as_json only: [:title]
  end
end
