FactoryBot.define do
  factory :user do
    first_name  { 'Abraham' }
    last_name   { 'Lincoln' }
    email       { 'candidate@abeforprez.com' }
    password    { 'grandideas' }
    location    { build(:location) }
  end

  factory :admin, parent: :user do
    first_name  { 'Stephen' }
    last_name   { 'Douglas' }
    email       { 'duggie@dugforprez.com' }
    password    { 'granderideas' }
    admin       { 'true' }
    location    { build(:location) }
  end
end
