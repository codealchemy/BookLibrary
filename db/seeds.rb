ActiveRecord::Base.transaction do
  location = Location.create!(name: 'Home')
  admin = User.create!(first_name: 'Admin', email: 'admin@example.test', password: 'admin123', admin: true, location: location)
  author = Author.create!(first_name: 'Paulo', last_name: 'Coelho')
  location.books.create!(authors: [author], title: 'The Alchemist', isbn: '9780061122415', owner: admin)
end
