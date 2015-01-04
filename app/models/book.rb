class Book < ActiveRecord::Base
  validates :title, :isbn, presence: true

  def author_name
    if author_first_name && author_last_name
      author_first_name + " " + author_last_name
    elsif author_first_name
      author_first_name
    elsif author_last_name
      author_last_name
    else
      "No author name given"
    end
  end

end
