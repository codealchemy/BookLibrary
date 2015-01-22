FactoryGirl.define do
  factory :location do |f|
    f.name 'DTLA Office'
    f.address1 '520 S. Grand Ave.'
    f.address2 '2nd Floor'
    f.city 'Los Angeles'
    f.state 'CA'
    f.zip '90071'
    f.country 'United States'
  end
end
