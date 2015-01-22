FactoryGirl.define do
  factory :book do |f|
    f.title 'The Alchemist'
    f.author_first_name 'Paulo'
    f.author_last_name 'Coelho'
    f.isbn '978-0061122415'
  end
end
