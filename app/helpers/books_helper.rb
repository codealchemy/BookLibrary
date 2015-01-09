module BooksHelper

  def users_full_names
    users = []
    User.find_each { |user| users << user.name}
    users
  end

end
