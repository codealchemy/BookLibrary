FactoryGirl.define do
  factory :location do
    name      { 'DTLA Office' }
    address1  { '520 S. Grand Ave.' }
    address2  { '2nd Floor' }
    city      { 'Los Angeles' }
    state     { 'CA' }
    zip       { '90071' }
    country   { 'United States' }
  end
end
