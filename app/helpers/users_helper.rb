module UsersHelper
  def time_with_book(user, book)
    loan = book.loans.where(user: user).last
    distance_of_time_in_words(Time.now - loan.checked_out_at)
  end
end
