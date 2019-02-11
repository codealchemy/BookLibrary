class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string  :title
      t.string  :subtitle
      t.string  :author_first_name
      t.string  :author_last_name
      t.string  :publisher
      t.string  :isbn,                 limit: 18
      t.text    :description
      t.timestamps
    end
  end
end
