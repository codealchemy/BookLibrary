class LoanManager
  attr_reader :book, :user

  def initialize(book, user)
    @book = book
    @user = user
  end

  def can_check_out?
    !active_loans.exists?
  end

  def user_has_book?
    active_loans.find_by(user: user).present?
  end

  private

  def active_loans
    book.loans.active
  end
end
