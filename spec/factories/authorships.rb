FactoryBot.define do
  factory :authorship do
    author { build(:author) }
    book   { build(:book) }
  end
end
