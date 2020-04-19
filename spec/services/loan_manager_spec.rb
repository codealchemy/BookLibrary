require 'rails_helper'

RSpec.describe LoanManager, type: :service do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  subject { described_class.new(book, user) }

  describe '#can_check_out?' do
    context 'no loans exist for book' do
      it { is_expected.to be_can_check_out }
    end

    context 'loan exists in the past' do
      before { book.loans.create(user: user, checked_out_at: 1.month.ago, checked_in_at: 1.month.ago) }

      it { is_expected.to be_can_check_out }
    end

    context 'active loan exists for book' do
      before { book.loans.create(user: user, checked_out_at: 1.month.ago, checked_in_at: nil) }

      it { is_expected.to_not be_can_check_out }
    end
  end

  describe '#user_has_book?' do
    context 'user does not have the book checked out' do
      it { is_expected.to_not be_user_has_book }
    end

    context 'user currently has the book checked out' do
      before { book.loans.create(user: user, checked_out_at: 1.month.ago, checked_in_at: nil) }

      it { is_expected.to be_user_has_book }
    end

    context 'another user has the book checked out' do
      before { book.loans.create(user: create(:admin), checked_out_at: 1.month.ago, checked_in_at: nil) }

      it { is_expected.to_not be_user_has_book }
    end
  end
end
