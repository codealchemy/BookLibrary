require 'rails_helper'

RSpec.describe Author, type: :model do
  let(:author) { build(:author) }

  context 'validations' do
    it 'is not valid without a first or last name' do
      author.assign_attributes(first_name: nil, last_name: nil)

      expect(author).to be_invalid
      expect(author.errors[:base]).to include('First or last name is required')
    end

    it 'is valid without a first name' do
      author.first_name = nil

      expect(author.last_name).to be_present
      expect(author).to be_valid
    end

    it 'is valid without a last name' do
      author.last_name = nil

      expect(author.first_name).to be_present
      expect(author).to be_valid
    end
  end

  describe '#name' do
    it 'pulls the first and last name of the author' do
      expect(author.name).to eq('Paulo Coelho')
    end

    it 'pulls the first name of the author if no last name exists' do
      author.last_name = nil

      expect(author.name).to eq('Paulo')
    end

    it 'pulls the last name of the author if no first name exists' do
      author.first_name = nil

      expect(author.name).to eq('Coelho')
    end
  end
end
