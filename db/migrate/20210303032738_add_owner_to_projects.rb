class AddOwnerToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column  :projects,  :owner_id, :integer
    add_foreign_key       :projects,    :users,   column: :owner_id
    change_column_null  :projects, :owner_id, false
  end
end
