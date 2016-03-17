require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe '#loan' do
    before { user.check_out(book) }

    it 'finds the loan for the user' do
      expect(loan(user, book)).to eq(Loan.where(user: user, book: book).last)
    end
  end

  describe '#human_boolean' do
    it "turns a 'true' into a 'yes'" do
      expect(human_boolean(true)).to eq('Yes')
    end

    it "turns a 'false' into a 'no'" do
      expect(human_boolean(false)).to eq('No')
    end
  end
end
