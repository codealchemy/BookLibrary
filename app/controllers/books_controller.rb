class BooksController < ApplicationController
  before_filter :find_book, only: [:show, :check_out, :check_in]
  before_action :authenticate_user!

  def index
    if params[:query].present?
      @books = Book.search(params[:query]).results
    else
      @books = Book.all
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

  def check_out
    current_user.check_out(@book)
    flash[:notice] = "You have checked out #{@book.title}, hope you enjoy it!"
    redirect_to books_path
  end

  def check_in
    current_user.check_in(@book)
    flash[:notice] = "You have checked in #{@book.title}, thanks!"
    redirect_to books_path
  end

  private

  def find_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(
        :title,
        :isbn,
        :author_first_name,
        :author_last_name,
        :description,
        :user_id
      )
  end
end
