require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'validations' do
    let(:book) { build(:book, title: 'Working') }

    it 'is not valid without an isbn' do
      book.isbn = nil

      expect(book).to be_invalid
      expect(book.errors[:isbn]).to include("can't be blank")
    end

    it 'is not valid without a title' do
      book.title = nil

      expect(book).to be_invalid
      expect(book.errors[:title]).to include("can't be blank")
    end

    it 'is valid with a title and ISBN' do
      book.assign_attributes(title: 'Title', isbn: '123456789-0')

      expect(book).to be_valid
    end
  end

  context 'before_save callbacks' do
    let(:book) { build(:book, isbn: '42-456-134-3') }

    it 'normalizes the isbn on save' do
      book.save

      expect(book.reload.isbn).to eq('424561343')
    end
  end

  context 'owner' do
    let(:user1) { create(:user, email: 'abe@example.com') }
    let(:user2) { create(:user, email: 'george@example.com') }
    let(:book)  { create(:book, owner: user1) }

    it 'returns the owner of a book' do
      expect(book.owner).to eq(user1)
    end

    it 'deletes associated books when owner is deleted' do
      user1.destroy

      expect(Book.where(user_id: user1.id)).to be_empty
    end
  end

  context 'borrowing' do
    let(:user) { create(:user) }
    let(:book) { create(:book, owner: user) }
    let(:loan) { user.loans.create(book: book) }

    it 'loans a book to a user and includes them in borrowed books list' do
      expect(loan.user).to eq(user)
      expect(loan.book).to eq(book)
      expect(book.borrower).to eq(user)
      expect(user.books_borrowed).to include(book)
    end

    it 'shows a book as available if not loaned out' do
      expect(book.borrowed?).to be_falsey
      expect(Book.checked_out).not_to include(book)
    end

    it 'shows a book as unavailable if it is loaned out' do
      expect(loan.book.borrowed?).to be_truthy
      expect(Book.checked_out).to include(book)
    end

    it 'deletes associated loans when book is deleted' do
      book.destroy

      expect(Loan.where(book_id: book.id)).to be_truthy
    end
  end
end
