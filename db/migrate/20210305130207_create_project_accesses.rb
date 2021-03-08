class CreateProjectAccesses < ActiveRecord::Migration[5.2]
  def change
    create_table :project_accesses do |t|
      t.references :user, foreign_key: true, null: false
      t.references :project, foreign_key: true, null: false
      t.boolean :is_owner,  null: false,  default: false

      t.timestamps
    end
  end
end
