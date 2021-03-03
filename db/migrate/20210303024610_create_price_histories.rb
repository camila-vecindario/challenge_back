class CreatePriceHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :price_histories do |t|
      t.date :start_date,   null: false
      t.date :end_date,     null: false
      t.decimal :value,     null: false

      t.timestamps
    end
  end
end
