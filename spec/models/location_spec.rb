require 'rails_helper'

RSpec.describe Location, type: :model do
  context '#books' do
    let(:location) { create(:location) }
    let(:user) { create(:user) }
    let(:book1) { create(:book, location: location) }
    let(:book2) do
      create(:book, 
             title: 'Autobio', 
             isbn: '978-0312404154',
             location: location)
    end

    before do
      user.check_out(book1)
      user.check_out(book2)
      user.check_in(book2)
    end

    it 'doesn\'t show checked-out books' do
      expect(location.available_books).not_to include(book1)
    end

    it 'shows available books' do
      expect(location.available_books).to include(book2)
    end
  end
end
