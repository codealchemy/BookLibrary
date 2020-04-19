class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.timestamps null: false
    end

    change_table :users do |t|
      t.belongs_to :location, index: true
    end

    change_table :books do |t|
      t.belongs_to :location, index: true
    end
  end
end
