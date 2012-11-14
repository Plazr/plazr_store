class CreatePlazrStoreProductProperties < ActiveRecord::Migration
  def change
    create_table :plazr_store_product_properties do |t|
      t.string :value, :null => false
      t.references :product
      t.references :property

      t.timestamps
    end
    add_index :plazr_store_store_properties, :product_id
    add_index :plazr_store_store_properties, :property_id
  end
end
