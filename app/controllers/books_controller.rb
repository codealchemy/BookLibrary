class BooksController < ApplicationController
  before_filter :find_book, only: [:show]
  before_action :authenticate_user!

  def index
    @books = Book.all
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
        :description
      )
  end

end
