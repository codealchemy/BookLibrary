class CreateLoans < ActiveRecord::Migration[4.2]
  def change
    create_table :loans do |t|
      t.belongs_to :user, index: true
      t.belongs_to :book, index: true
      t.datetime :checked_out_at
      t.datetime :checked_in_at
      t.datetime :due_date
      t.datetime :updated_at
    end
  end
end
