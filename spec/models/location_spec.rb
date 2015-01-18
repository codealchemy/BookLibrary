require 'rails_helper'

RSpec.describe Location, type: :model do
  context '#books' do
    let(:location) { Location.create(name: 'Test office') }
    let(:user) do
      location.users.create(email: 'roger@rabbit.com', password: 'asdfasdf')
    end
    let(:book1) do
      location.books.create(title: 'Another', isbn: '234-537-5342')
    end
    let(:book2) { location.books.create(title: 'One', isbn: '234-5436-234') }

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
