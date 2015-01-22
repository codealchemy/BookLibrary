FactoryGirl.define do
  factory :loan do |f|
    f.user user
    f.book book
  end
end
