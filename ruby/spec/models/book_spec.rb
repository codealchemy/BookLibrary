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
end
