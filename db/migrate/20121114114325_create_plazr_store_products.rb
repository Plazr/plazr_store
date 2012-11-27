class CreatePlazrStoreProducts < ActiveRecord::Migration
  def change
    create_table :plazr_store_products do |t|
      t.string :name, :null => false
      t.text :details
      t.string :permalink
      t.decimal :price_max
      t.decimal :price_min
      t.decimal :rating
      t.boolean :active, :null => false, :default => true
      t.references :brand
      t.references :prototype
      t.datetime :available_at
      # t.datetime :deleted_at

      t.timestamps
    end
    add_index :plazr_store_products, :brand_id
    add_index :plazr_store_products, :prototype_id
    add_index :plazr_store_products, :available_at
    add_index :plazr_store_products, :permalink
    add_index :plazr_store_products, :name
  end
end
