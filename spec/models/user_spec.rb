require 'rails_helper'

RSpec.describe User, type: :model do
  context '#user names' do
    let(:user) { build(:user) }

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

    it 'returns a message for no name for the user' do
      user.first_name = nil
      user.last_name = nil
      expect(user.name).to eq('No name')
    end
  end

  context '#emails' do
    let(:user) { build(:user) }

    it 'sends a signup email' do
      expect { user.send_signup_email }.to(
        change { ActionMailer::Base.deliveries.count }.by(1)
      )
    end

    it 'sends an overdue email' do
      expect { user.send_overdue_email }.to(
        change { ActionMailer::Base.deliveries.count }.by(1)
      )
    end
  end

  context '#borrowing' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }

    before do 
      user.check_out(book)
    end

    it 'pulls a list of borrowed books for user' do
      expect(user.books_borrowed).to include(book)
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
