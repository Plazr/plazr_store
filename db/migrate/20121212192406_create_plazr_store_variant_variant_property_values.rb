class CreatePlazrStoreVariantVariantPropertyValues < ActiveRecord::Migration
  def change
    create_table :plazr_store_variant_variant_property_values do |t|
      t.references :variant, :null => false
      t.references :variant_property_value, :null => false

      t.timestamps
    end
    add_index :plazr_store_variant_variant_property_values, [:variant_id, :variant_property_value_id], :unique => true, :name => 'index_variant_variant_property_value'
  end
end
