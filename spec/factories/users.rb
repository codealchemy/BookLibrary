FactoryGirl.define do
  factory :user do |f|
    f.first_name 'Abraham'
    f.last_name 'Lincoln'
    f.email 'candidate@abeforprez.com'
    f.password 'grandideas'
  end

  factory :admin, parent: :user do |f|
    f.first_name 'Stephen'
    f.last_name 'Douglas'
    f.email 'duggie@dugforprez.com'
    f.password 'granderideas'
    f.admin 'true'
  end
end
