require 'rails_helper'

RSpec.describe Authorship, type: :model do
  context 'validations' do
    it 'is not valid without a book' do
      authorship = build(:authorship, book: nil)

      expect(authorship).to be_invalid
    end

    it 'is not valid without an author' do
      authorship = build(:authorship, author: nil)

      expect(authorship).to be_invalid
    end

    it 'is not valid if another exists with the same author and book' do
      authorship = create(:authorship)
      duplicate_authorship = build(:authorship, book: authorship.book, author: authorship.author)

      expect(duplicate_authorship).to be_invalid
      expect { duplicate_authorship.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'is valid with a book and an author' do
      authorship = build(:authorship)

      expect(authorship).to be_valid
    end
  end
end
