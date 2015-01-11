class Book < ActiveRecord::Base
  searchkick
  validates :title, :isbn, presence: true
  belongs_to :user
  has_many :loans
  has_many :borrowers, class_name: 'Loan', foreign_key: :book_id
  after_destroy :delete_associated_loans

  def author_name
    name = [author_first_name, author_last_name].map(&:to_s).join(' ').strip
    name.empty? ? 'No author name given' : name
  end

  def owner
    User.find(user_id) if user_id
  end

  def change_owner(user = nil)
    return unless user
    self.user = user
    save
  end

  def borrowed?
    Loan.where(book: self, checked_in_at: nil).empty? ? false : true
  end

  def borrower
    if Loan.where(book: self, checked_in_at: nil).empty?
      nil
    else
      Loan.where(book: self, checked_in_at: nil).last.user
    end
  end

  def self.checked_out_books
    books = []
    Book.find_each { |book| book.borrowed? ? books << book : next }
    books
  end

  def self.available_books
    books = []
    Book.find_each { |book| book.borrowed? ? next : books << book }
    books
  end

  def delete_associated_loans
    Loan.where(book: self).destroy_all
  end

  def search_data
    as_json only: [:title]
  end
end
