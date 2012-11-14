class CreatePlazrStoreProducts < ActiveRecord::Migration
  def change
    create_table :plazr_store_products do |t|
      t.string :name
      t.string :details
      t.string :permalink
      t.decimal :price_max
      t.decimal :price_min
      t.decimal :rating
      t.boolean :active
      t.datetime :available_at
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
