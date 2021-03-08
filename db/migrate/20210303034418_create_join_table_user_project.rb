class CreateJoinTableUserProject < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :projects, table_name: :project_leads do |t|
      t.index [:user_id, :project_id]
      t.index [:project_id, :user_id]
    end
  end
end
