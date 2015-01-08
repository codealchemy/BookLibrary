require 'rails_helper'

RSpec.describe Loan, :type => :model do
  context "#validations" do
    let(:user) { User.create(email: 'alex@example.com', password: 'abc1das23456') }
    let(:book) { Book.create(title: "A new start", isbn: "234-432-55-123") }

    it "is invalid without a book" do
      loan = Loan.new(user: user)
      expect(loan.valid?).to eq(false)
    end

    it "is invalid without a user" do
      loan = Loan.new(book: book)
      expect(loan.valid?).to eq(false)
    end
  end
end
