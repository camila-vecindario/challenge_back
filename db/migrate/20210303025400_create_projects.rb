class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name,               null: false
      t.integer :type_project,      null: false,    default: 0
      t.string :address,            null: false
      t.boolean :has_vis,           null: false,    default: false
      t.float :private_area,        null: false
      t.float :built_area,          null: false
      t.integer :bathrooms,         null: false, default: 1
      t.boolean :has_parking,       null: false, default: false
      t.string :sales_room_emails,  null: false

      t.timestamps
    end
  end
end
