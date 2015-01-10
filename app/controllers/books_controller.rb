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
        redirect_to books_path, notice: "Book saved"
      else
        redirect_to new_book_path, alert: "There's an error - please check the required fields"
      end
  end

  def show
  end

  def check_out
    current_user.check_out(@book)
    redirect_to books_path, notice: "You have checked out #{@book.title}, hope you enjoy it!"
  end

  def check_in
    current_user.check_in(@book)
    redirect_to books_path, notice: "You have checked in #{@book.title}, thanks!"
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
