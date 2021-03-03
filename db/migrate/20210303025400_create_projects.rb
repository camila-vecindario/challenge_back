class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name,               null: false
      t.string :type,               limit: 1
      t.string :address,            null: false
      t.boolean :has_vis,           default: false
      t.integer :private_areas
      t.integer :public_areas
      t.integer :bathrooms,         default: 1
      t.boolean :has_parking,       default: false
      t.string :sales_room_emails,  null: false

      t.timestamps
    end
  end
end
