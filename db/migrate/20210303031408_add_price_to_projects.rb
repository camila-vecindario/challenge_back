class AddPriceToProjects < ActiveRecord::Migration[5.2]
  def change
    add_reference   :projects,  :price, foreign_key: { to_table: :price_histories }
  end
end
