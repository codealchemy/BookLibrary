require 'rails_helper'

RSpec.describe Authorship, type: :model do
  context 'validations' do
    let(:author)     { create(:author) }
    let(:book)       { create(:book) }
    let(:authorship) { create(:authorship)}

    it 'is not valid without a book' do
      authorship.book = nil

      expect(authorship).to be_invalid
      expect(authorship.errors[:book]).to include("can't be blank")
    end

    it 'is not valid without an author' do
      authorship.author = nil

      expect(authorship).to be_invalid
      expect(authorship.errors[:author]).to include("can't be blank")
    end

    it 'is not valid if another exists with the same author and book' do
      duplicate_authorship = build(:authorship, book: authorship.book, author: authorship.author)

      expect(duplicate_authorship).to be_invalid
      expect { duplicate_authorship.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'is valid with a book and an author' do
      authorship.assign_attributes(book: book, author: author)

      expect(authorship).to be_valid
    end
  end
end
