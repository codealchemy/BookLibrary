class Book < ActiveRecord::Base

  validates :title, :isbn, presence: true

end
