class CreatePlazrStorePrototypeVariantProperties < ActiveRecord::Migration
  def change
    create_table :plazr_store_prototype_variant_properties do |t|
    t.references :prototype, :null => false
    t.references :variant_property, :null => false

    t.timestamps
    end
    add_index :plazr_store_prototype_variant_properties, [:prototype_id, :variant_property_id], :unique => true, :name => 'index_prototype_variant_property'
  end
end
