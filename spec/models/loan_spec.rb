require 'rails_helper'

RSpec.describe Loan, type: :model do
  context '#validations' do
    let(:user) do
      User.create(email: 'alex@example.com',
                  password: 'abc1das23456')
    end
    let(:book) { Book.create(title: 'A new start', isbn: '234-432-55-123') }

    it 'is invalid without a book' do
      loan = Loan.new(user: user)
      expect(loan.valid?).to eq(false)
    end

    it 'is invalid without a user' do
      loan = Loan.new(book: book)
      expect(loan.valid?).to eq(false)
    end

    it 'is valid with both user and book' do
      loan = Loan.new(book: book, user: user)
      expect(loan.valid?).to eq(true)
    end
  end
end
