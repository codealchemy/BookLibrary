require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  it 'calculates the time a book has been checked out for humans' do
    loan = user.loans.create(book: book, checked_out_at: Time.now - 2.months)

    expect(time_with_book(user, book)).to include('2 months')
  end
end
