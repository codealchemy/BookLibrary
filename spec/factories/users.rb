FactoryGirl.define do
  factory :user do |f|
    f.first_name 'Abraham'
    f.last_name 'Lincoln'
    f.email 'candidate@abeforprez.com'
    f.password 'grandideas'
  end
end