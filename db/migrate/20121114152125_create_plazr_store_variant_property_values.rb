class CreatePlazrStoreVariantPropertyValues < ActiveRecord::Migration
  def change
    create_table :plazr_store_variant_property_values do |t|
      t.string :value, :null => false
      t.references :variant, :null => false
      t.references :variant_property, :null => false

      t.timestamps
    end
    add_index :plazr_store_variant_property_values, [:variant_id, :variant_property_id], :unique => true, :name => 'index_variant_property_value'
  end
end
