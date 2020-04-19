require 'rails_helper'

RSpec.describe AmazonBook do
  before do
    # Both methods of searching return an AmazonResponse object
    allow(Amazon::Ecs).to receive(:item_lookup).and_return(amazon_response)
    allow(Amazon::Ecs).to receive(:item_search).and_return(amazon_response)
  end

  let(:amazon_response) do
    Amazon::Ecs::Response.new(File.read(File.expand_path('../../fixtures/item_search.xml', __FILE__)))
  end
  let!(:book) { create(:book, isbn: '9780596523008') }
  let(:amazon_book) { described_class.new(book.isbn) }

  describe 'collect_links' do
    it 'assigns links to the instance when links are found' do
      expect(amazon_book.main_page_link).to be_present
      expect(amazon_book.image_link).to be_present
      expect(amazon_book.reviews_link).to be_present
      expect(amazon_book.marketplace_link).to be_present
    end
  end

  describe '#search_by_isbn' do
    it 'instantiates a new AmazonBook and queries Amazon' do
      expect(described_class).to receive(:new).with(book.isbn)

      described_class.search_by_isbn(book.isbn)
    end
  end

  # Private methods

  describe 'item_lookup' do
    it 'searches Amazon for book by isbn' do
      expect(amazon_book.send(:item_lookup)).to eq(amazon_response)
    end
  end

  describe 'image_lookup' do
    it 'searches Amazon for book by isbn' do
      expect(amazon_book.send(:image_lookup)).to eq(amazon_response)
    end
  end

  describe 'retrieve_image_link' do
    it 'retrieves an image link when present' do
      expect(amazon_book.send(:retrieve_image_link)).to eq(
        'http://ecx.images-amazon.com/images/I/415NS3cmtrL.jpg'
      )
    end
  end

  describe 'retrieve_main_page_link' do
    it 'retrieves the main page link when present' do
      expect(amazon_book.send(:retrieve_main_page_link)).to eq(
        'http://www.amazon.com/Ruby-Programming-Language-David-Flanagan/dp/'\
        '0596516177%3FSubscriptionId%3D0XQXXC6YV2C85DX1BF02%26tag%3Dws%26link'\
        'Code%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3D0596516177'
      )
    end
  end

  describe 'retrieve_marketplace_link' do
    it 'retrieves the marketplace link when present' do
      expect(amazon_book.send(:retrieve_marketplace_link)).to eq(
        'http://www.amazon.com/gp/offer-listing/0596516177%3FSubscriptionId%3D0'\
        'XQXXC6YV2C85DX1BF02%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creati'\
        've%3D386001%26creativeASIN%3D0596516177'
      )
    end
  end

  describe 'retrieve_reviews_link' do
    it 'retrieves the reviews link when present' do
      expect(amazon_book.send(:retrieve_reviews_link)).to eq(
        'http://www.amazon.com/review/product/0596516177%3FSubscriptionId%3D0XQ'\
        'XXC6YV2C85DX1BF02%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative'\
        '%3D386001%26creativeASIN%3D0596516177'
      )
    end
  end

  describe 'retrieve_link' do
    it 'matches the associated link by the provided regex' do
      expect(amazon_book.send(:retrieve_link, /link/i)).to eq(
      'http://www.amazon.com/Ruby-Programming-Language-David-Flanagan/dp/tech-data'\
      '/0596516177%3FSubscriptionId%3D0XQXXC6YV2C85DX1BF02%26tag%3Dws%26linkCode%3'\
      'Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0596516177'
      )
    end
  end

  describe 'validate_isbn' do
    it 'is truthy when isbn is valid' do
      expect(amazon_book.send(:validate_isbn, book.isbn)).to be_truthy
    end

    it 'is falsy when isbn is not valid' do
      invalid_isbn = book.isbn + '0987654321'
      expect(amazon_book.send(:validate_isbn, invalid_isbn)).to be_falsy
    end
  end
end
