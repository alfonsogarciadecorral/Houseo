class CreateFlats < ActiveRecord::Migration[5.2]
  def change
    create_table :flats do |t|
      t.string :title
      t.integer :number_of_rooms
      t.integer :price
      t.string :address
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
