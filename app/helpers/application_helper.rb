module ApplicationHelper

  def human_boolean(boolean)
    boolean ? 'Yes' : 'No'
  end

  def loan(user, book)
    Loan.where(user: user, book: book).last
  end
end
