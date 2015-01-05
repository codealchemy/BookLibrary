class Book < ActiveRecord::Base
  validates :title, :isbn, presence: true

  def author_name
    name = [author_first_name, author_last_name].map(&:to_s).join(" ").strip
    name.empty? ? "No author name given" : name
  end

end
