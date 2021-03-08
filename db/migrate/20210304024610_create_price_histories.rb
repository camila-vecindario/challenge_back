class CreatePriceHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :price_histories do |t|
      t.decimal :value,     null: false
      t.references :project, foreign_key: true, null: false

      t.timestamps
    end
  end
end
