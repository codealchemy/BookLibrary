class Location < ActiveRecord::Base
  has_many :users
  has_many :books

  def available_books
    books = []
    Book.find_each { |book| book.location == self && book.borrowed? == false ? books << book : next }
    books
  end
end
