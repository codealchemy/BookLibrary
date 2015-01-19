class BooksController < ApplicationController
  before_filter :find_book, except: [:index, :create, :new]
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction


  def index
    if params[:query].present?
      books = Book.search(params[:query])
      @books = Kaminari.paginate_array(books.results).page(params[:page]).per(15)
    else
      @books = Book.page(params[:page]).per(15).order(sort_column + " " + sort_direction)
      respond_to do |format|
        format.js
        format.html
      end
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = 'Book saved'
      redirect_to books_path
    else
      flash[:alert] = 'There\'s an error - please check the required fields'
      redirect_to new_book_path
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @book.destroy
    flash[:alert] = 'Book has been deleted'
    redirect_to books_path
  end

  def update
    @book.update(book_params)
    if @book.save
      flash[:notice] = 'Book saved'
      redirect_to book_path(@book)
    else
      flash[:alert] = 'There\'s an error - please check the required fields'
      redirect_to new_book_path
    end
  end

  def check_out
    current_user.check_out(@book)
    loan = Loan.where(user: current_user, book: @book, checked_in_at: nil).last
    Nb::Contacts.log_contact(loan, 'Book check-out')
    flash[:notice] = "You have checked out #{@book.title}, hope you enjoy it!"
    redirect_to books_path
  end

  def check_in
    current_user.check_in(@book)
    loan = Loan.where(user: current_user, book: @book).last
    Nb::Contacts.log_contact(loan, 'Book check-in')
    flash[:notice] = "You have checked in #{@book.title}, thanks!"
    redirect_to books_path
  end

  private

  def find_book
    @book = Book.find(params[:id])
    @links = AmazonBook.search_by_isbn(@book.isbn)
  end

  def book_params
    params.require(:book).permit(
        :title,
        :subtitle,
        :isbn,
        :author_first_name,
        :author_last_name,
        :description,
        :user_id,
        :location_id
      )
  end

  def sort_column
    Book.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
