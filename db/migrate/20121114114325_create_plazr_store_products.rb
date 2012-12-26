class CreatePlazrStoreProducts < ActiveRecord::Migration
  def change
    create_table :plazr_store_products do |t|
      t.string :name, :null => false
      t.text :details
      t.string :slug
      t.decimal :rating
      t.references :brand
      t.datetime :available_at

      t.timestamps
    end
    add_index :plazr_store_products, :brand_id
    add_index :plazr_store_products, :available_at
    add_index :plazr_store_products, :slug, unique: true
    add_index :plazr_store_products, :name
  end
end
