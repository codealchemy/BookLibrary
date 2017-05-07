class User < ActiveRecord::Base

  # Included devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :books_owned, class_name: 'Book', foreign_key: :user_id, dependent: :destroy
  has_many :loans, dependent: :destroy
  has_many :books_borrowed, through: :loans, source: :book
  belongs_to :location

  # Scopes
  scope :with_books, -> { joins(:loans).merge(Loan.active) }

  def name
    full_name = "#{first_name} #{last_name}".strip
    full_name.empty? ? email : full_name
  end

  def send_signup_email
    UserNotifier.send_signup_email(self).deliver_now
  end

  def send_overdue_email
    UserNotifier.send_overdue_email(self).deliver_now
  end
end
