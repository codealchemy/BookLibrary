require 'rails_helper'

RSpec.describe Loan, type: :model do
  context 'validations' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }

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
