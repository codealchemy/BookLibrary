class AddBookOwners < ActiveRecord::Migration
  change_table "books", force: true do |t|
    t.belongs_to :user
  end
end
