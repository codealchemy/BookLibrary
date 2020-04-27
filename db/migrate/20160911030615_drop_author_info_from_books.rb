class DropAuthorInfoFromBooks < ActiveRecord::Migration[4.2]
  def up
    remove_column :books, :author_first_name
    remove_column :books, :author_last_name
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
