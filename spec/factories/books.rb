FactoryGirl.define do
  factory :book do
    title             { 'The Alchemist' }
    author_first_name { 'Paulo' }
    author_last_name  { 'Coelho' }
    isbn              { '978-0061122415' }
  end
end
