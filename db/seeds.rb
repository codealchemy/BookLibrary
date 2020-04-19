ActiveRecord::Base.transaction do
  admin = User.create!(first_name: 'Admin', email: 'admin@example.test', password: 'admin123', admin: true)
  location = admin.create_location!(name: 'Home')
  author = Author.create!(first_name: 'Paulo', last_name: 'Coelho')
  location.books.create!(authors: [author], title: 'The Alchemist', isbn: '9780061122415')
end
