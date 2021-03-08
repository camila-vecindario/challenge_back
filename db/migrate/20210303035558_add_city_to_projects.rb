class AddCityToProjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects,  :location,  foreign_key:  { to_table: :locations }
  end
end
