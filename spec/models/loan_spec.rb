require 'rails_helper'

RSpec.describe Loan, type: :model do
  context 'validations' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }
    let(:loan) { build(:loan) }

    it 'is invalid without a book' do
      loan.book = nil

      expect(loan).to be_invalid
      expect(loan.errors[:book]).to include("can't be blank")
    end

    it 'is invalid without a user' do
      loan.user = nil

      expect(loan).to be_invalid
      expect(loan.errors[:user]).to include("can't be blank")
    end

    it 'is valid with both user and book' do
      loan.assign_attributes(user: user, book: book)

      expect(loan).to be_valid
    end
  end
end
