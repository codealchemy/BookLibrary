class Book < ActiveRecord::Base
  validates :title, :isbn, presence: true

  def author_name
    author_first_name + " " + author_last_name
  end

end
