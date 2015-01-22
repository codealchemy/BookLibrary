require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  it 'finds the loan for the user' do
    user.check_out(book)
    expect(loan(user, book)).to eq(Loan.where(user: user, book: book).last)
  end
end
