class CreatePlazrStoreProductProperties < ActiveRecord::Migration
  def change
    create_table :plazr_store_product_properties do |t|
      t.string :value, :null => false
      t.references :product, :null => false
      t.references :property, :null => false

      t.timestamps
    end
    add_index :plazr_store_product_properties, [:product_id, :property_id], :unique => true, :name => 'index_product_property'
  end
end
