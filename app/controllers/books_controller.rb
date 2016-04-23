class BooksController < ApplicationController
  before_filter :find_book, except: [:index]
  before_action :authenticate_user!

  def index
    if params[:query].present?
      books = Book.search(params[:query])
      @books = Kaminari.paginate_array(books.results).page(params[:page]).per(15)
    else
      @books = Book.page(params[:page]).per(15)
    end
  end

  def show
    @links = AmazonBook.search_by_isbn(@book.isbn)
  end

  def check_out
    current_user.check_out(@book)
    loan = Loan.where(user: current_user, book: @book, checked_in_at: nil).last
    Nb::Contacts.log_contact(loan, 'Book check-out')
    flash[:notice] = I18n.t('books.check_out', book_title: @book.title)
    redirect_to books_path
  end

  def check_in
    current_user.check_in(@book)
    loan = Loan.where(user: current_user, book: @book).last
    Nb::Contacts.log_contact(loan, 'Book check-in')
    flash[:notice] = I18n.t('books.check_in', book_title: @book.title)
    redirect_to books_path
  end

  private

  def find_book
    @book = Book.find(params[:id])
    @borrower = @book.borrower
  end
end
