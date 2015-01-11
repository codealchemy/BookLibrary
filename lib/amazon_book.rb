class AmazonBook
  attr_accessor :image_link, :main_page_link, :reviews_link, :marketplace_link,
                :isbn, :item

  def initialize(isbn)
    @isbn = isbn
    @item = item_lookup
    @main_page_link = retrieve_main_page_link
    @image_link = retrieve_image_link
    @reviews_link = retrieve_reviews_link
    @marketplace_link = retrieve_marketplace_link
  end

  def self.search_by_isbn(isbn)
    new(isbn)
  end

  private
  def retrieve_image_link
    exit_if_no_isbn_or_item
    image = image_lookup.items.first
    return unless image
    image.get_element('LargeImage/URL').to_s.gsub(/<URL>|<\/URL>/,'')
  end

  def retrieve_main_page_link
    exit_if_no_isbn_or_item
    item.get_hash['DetailPageURL']
  end

  def retrieve_reviews_link
    exit_if_no_isbn_or_item
    raw_link = item.get_array('ItemLink').select{|i| i =~ /reviews/i }.first
    link = raw_link.match(/<URL>(.*?)<\/URL>/)[1] if raw_link
  end

  def retrieve_marketplace_link
    exit_if_no_isbn_or_item
    raw_link = item.get_array('ItemLink').select{|i| i =~ /all offers/i }.first
    link = raw_link.match(/<URL>(.*?)<\/URL>/)[1] if raw_link
  end

  def exit_if_no_isbn_or_item
    return unless isbn && item
  end

  def item_lookup
    AMZ.item_lookup(isbn,
      {
        id_type: 'ISBN',
        search_index: 'Books',
        include_reviews_summary: true,
        response_group: 'ItemAttributes'
      }
    ).items.first
  end

  def image_lookup
    AMZ.item_search(isbn, response_group: 'Images')
  end
end