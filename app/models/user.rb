class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :books_owned, class_name: 'Book', foreign_key: :user_id, dependent: :destroy
  has_many :loans, dependent: :destroy
  has_many :books, through: :loans
  belongs_to :location

  def make_admin
    update(admin: true)
  end

  def remove_admin
    update(admin: false)
  end

  def send_signup_email
    UserNotifier.send_signup_email(self).deliver
  end

  def send_overdue_email
    UserNotifier.send_overdue_email(self).deliver
  end

  def name
    name = [first_name, last_name].map(&:to_s).join(' ').strip
    name.empty? ? 'No name' : name
  end

  def books_borrowed
    books
  end

  def books_checked_out
    book_ids = Loan.where(user: self, checked_in_at: nil).pluck(:book_id)
    Book.find(book_ids)
  end

  def overdue_books
    loans = Loan.where(user: self)
    loans = loans.where('due_date IS NOT NULL AND due_date < current_date')
    book_ids = loans.pluck(:book_id)
    Book.find(book_ids)
  end

  def self.with_books
    checked_out_books = Loan.where(checked_in_at: nil).pluck(:user_id)
    User.find(checked_out_books)
  end

  def check_out(book)
    loans.create(book: book, checked_out_at: Time.now)
  end

  def check_in(book)
    loan = loans.where(book: book, checked_in_at: nil).first
    loan.update(checked_in_at: Time.now)
  end
end
