require 'rails_helper'

RSpec.describe Book, :type => :model do
  context "#validations" do
    it "is not valid without a title AND isbn" do 
      book = Book.new(title: 'Something')
      expect(book.valid?).to be(false)
    end

    it "is valid with a title and ISBN" do
      book = Book.new(title: 'Working', isbn: '42-456-134-3')
      expect(book.valid?).to be(true)
    end
  end

  context "#author names" do
    let(:book) { Book.create(author_first_name: "Alex", author_last_name: "Schmitt", isbn: "123-45-6789-01", title: "Tests and more...") }
    let(:book_with_first_name) { Book.create(author_first_name: "Alex", isbn: "123-45-6789-01", title: "Tests and more...") }
    let(:book_with_last_name) { Book.create(author_last_name: "Schmitt", isbn: "123-45-6789-01", title: "Tests and more...") }
    let(:book_no_author) { Book.create(isbn: "123-45-6789-01", title: "Tests and more...") }

    it "pulls the first and last name of the author" do 
      expect(book.author_first_name).to eq("Alex")
      expect(book.author_last_name).to eq("Schmitt")
      expect(book.author_name).to eq("Alex Schmitt")
    end

    it "pulls the first name of the author if last name doesn't exist" do
      expect(book_with_first_name.author_first_name).to eq("Alex")
      expect(book_with_first_name.author_last_name).to eq(nil)
      expect(book_with_first_name.author_name).to eq("Alex")
    end

    it "pulls the last name of the author" do 
      expect(book_with_last_name.author_last_name).to eq("Schmitt")
      expect(book_with_last_name.author_first_name).to eq(nil)
      expect(book_with_last_name.author_name).to eq("Schmitt")
    end

    it "returns a message for no author" do 
      expect(book_no_author.author_name).to eq("No author name given")
    end
  end

  context "#owner" do 
    let(:user1) { User.create(email: 'alex@example.com', password: 'abc1das23456') }
    let(:user2) { User.create(email: 'bobbie@example.com', password: 'anotherpw') }
    let(:book) { user1.books.create(title: "A new start", isbn: "234-432-55-123") }

    it "returns the owner of a book" do 
      expect(book.owner).to eq(user1)
    end

    it "changes the owner" do 
      book.change_owner(user2)
      expect(book.owner).to eq(user2)
    end

    it "doesn't change owner without argument" do
      book.change_owner
      expect(book.owner).to eq(user1)
    end
  end
end
