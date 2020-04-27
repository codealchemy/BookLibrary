class AddBookOwners < ActiveRecord::Migration[4.2]
  change_table "books", force: true do |t|
    t.belongs_to :user
  end
end
