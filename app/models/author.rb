class Author < ActiveRecord::Base

  # Associations
  has_many :authorships, dependent: :destroy
  has_many :books, through: :authorships

  # Validations
  validate { first_or_last_name_required if name.blank? }

  def name
    "#{first_name} #{last_name}".strip
  end

  private

  def first_or_last_name_required
    errors.add(:base, 'First or last name is required')
  end
end
