require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context '#name' do
    it 'pulls the first and last name of the user' do
      expect(user.name).to eq('Abraham Lincoln')
    end

    it 'pulls the first name of the user if no last name exists' do
      user.last_name = nil

      expect(user.name).to eq('Abraham')
    end

    it 'pulls the last name of the user if no first name exists' do
      user.first_name = nil

      expect(user.name).to eq('Lincoln')
    end

    it 'returns the users email if no first or last name is given' do
      user.assign_attributes(first_name: nil, last_name: nil)

      expect(user.name).to eq(user.email)
    end
  end

  context 'emails' do
    it 'sends a signup email' do
      expect do
        user.send_signup_email
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'sends an overdue email' do
      expect do
        user.send_overdue_email
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  context 'borrowing' do
    let(:book) { create(:book) }

    before do
      user.check_out(book)
    end

    it 'returns a list of borrowed books for user' do
      expect(user.books_checked_out).to include(book)
    end

    it 'returns a list of overdue books for user' do
      user.loans.active.first.update_attributes(due_date: Date.yesterday)

      expect(user.books_overdue).to include(book)
    end

    it 'checks out a book' do
      expect(book.borrowed?).to eq(true)
      expect(book.borrower).to eq(user)
      expect { user.check_out(book) }.to change { Loan.count }.by(1)
    end

    it 'checks in a book' do
      user.check_in(book)

      expect(book.borrowed?).to eq(false)
    end
  end
end
