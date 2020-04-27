class AddAuthorsToBooks < ActiveRecord::Migration[4.2]
  def change
    create_table(:authors) do |t|
      t.string :first_name
      t.string :last_name
      t.timestamps
    end

    create_table(:authorships) do |t|
      t.belongs_to :author, null: false
      t.belongs_to :book, null: false
    end

    add_index :authorships, [:author_id, :book_id], unique: true
  end
end
