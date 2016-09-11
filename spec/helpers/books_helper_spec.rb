require 'rails_helper'

RSpec.describe BooksHelper, type: :helper do
  let(:book) { create(:book) }

  describe '#author_names' do
    it "returns a string of the books authors' names" do
      expected_names = book.authors.map(&:name).join(', ')

      expect(author_names(book)).to eq(expected_names)
    end
  end
end
