class AmazonBook
  attr_accessor :image_link, :main_page_link, :reviews_link, :marketplace_link,
                :isbn, :item

  def initialize(isbn)
    @isbn = validate_isbn(isbn)
    @item = item_lookup.items.first
    collect_links
  end

  def self.search_by_isbn(isbn)
    new(isbn)
  end

  def collect_links
    return unless isbn && item
    self.main_page_link = retrieve_main_page_link
    self.image_link = retrieve_image_link
    self.reviews_link = retrieve_reviews_link
    self.marketplace_link = retrieve_marketplace_link
  end

  private

  def item_lookup
    return unless isbn
    Amazon::Ecs.item_lookup(isbn,
      {
        id_type: 'ISBN',
        search_index: 'Books',
        include_reviews_summary: true,
        response_group: 'ItemAttributes'
      }
    )
  end

  def image_lookup
    Amazon::Ecs.item_search(isbn, response_group: 'Images')
  end

  def retrieve_image_link
    image = image_lookup.items.first
    image.get_element('LargeImage/URL').to_s.gsub(/<URL>|<\/URL>/,'') if image
  end

  def retrieve_main_page_link
    item.get_hash['DetailPageURL']
  end

  def retrieve_marketplace_link
    raw_link = item.get_array('ItemLink').select { |i| i =~ /all offers/i }.first
    link = raw_link.match(/<URL>(.*?)<\/URL>/)[1] if raw_link
  end

  def retrieve_reviews_link
    raw_link = item.get_array('ItemLink').select { |i| i =~ /reviews/i }.first
    link = raw_link.match(/<URL>(.*?)<\/URL>/)[1] if raw_link
  end

  def validate_isbn(isbn)
    length = isbn.to_s.gsub(/\D/,'').length
    isbn if length == 10 || length == 13
  end
end
