class User < ActiveRecord::Base

  # Included devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :books_owned, class_name: 'Book', foreign_key: :user_id, dependent: :destroy
  has_many :loans, dependent: :destroy
  has_many :books_borrowed, through: :loans, source: :book
  belongs_to :location

  # Scopes
  scope :with_books, -> { joins(:loans).merge(Loan.active) }

  def name
    full_name = "#{first_name} #{last_name}".strip
    full_name.empty? ? email : full_name
  end

  def make_admin
    update(admin: true)
  end

  def remove_admin
    update(admin: false)
  end

  def send_signup_email
    UserNotifier.send_signup_email(self).deliver_now
  end

  def send_overdue_email
    UserNotifier.send_overdue_email(self).deliver_now
  end

  def books_checked_out
    loans.active.map(&:book)
  end

  def books_overdue
    loans.overdue.map(&:book)
  end

  def check_out(book)
    loans.create(book: book, checked_out_at: Time.now)
  end

  def check_in(book)
    loan = loans.active.find_by_book_id(book.id)
    loan.update(checked_in_at: Time.now)
  end
end
