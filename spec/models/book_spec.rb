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
end
