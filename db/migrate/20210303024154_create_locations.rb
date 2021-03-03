class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.integer :location_id
      t.string :name

      t.timestamps
    end
  end
end
