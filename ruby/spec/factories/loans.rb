FactoryBot.define do
  factory :loan do
    user { build(:user) }
    book { build(:book) }
  end
end
