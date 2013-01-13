class CreatePlazrStoreProductVariantProperties < ActiveRecord::Migration
  def change
    create_table :plazr_store_product_variant_properties do |t|
    t.references :product, :null => false
    t.references :variant_property, :null => false

    t.timestamps
    end
    add_index :plazr_store_product_variant_properties, [:product_id, :variant_property_id], :unique => true, :name => 'index_product_variant_property'
  end
end
