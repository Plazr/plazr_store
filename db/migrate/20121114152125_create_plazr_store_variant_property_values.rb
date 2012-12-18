class CreatePlazrStoreVariantPropertyValues < ActiveRecord::Migration
  def change
    create_table :plazr_store_variant_property_values do |t|
      t.string :name
      t.string :presentation, :null => false
      t.references :variant_property, :null => false

      t.timestamps
    end
    add_index :plazr_store_variant_property_values, :variant_property_id
  end
end
