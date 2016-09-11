require 'rails_helper'

RSpec.describe Author, type: :model do
  context 'validations' do
    let(:author) { create(:author) }

    it 'is not valid without a first or last name' do
      author.first_name = nil
      author.last_name = nil

      expect(author).to be_invalid
    end

    it 'is valid without a first name' do
      author.first_name = nil

      expect(author).to be_valid
    end

    it 'is valid without a last name' do
      author.last_name = nil

      expect(author).to be_valid
    end
  end
end
