module BooksHelper
  def author_names(book)
    book.authors.map(&:name).join(', ')
  end
end
