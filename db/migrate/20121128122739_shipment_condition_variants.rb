class ShipmentConditionVariants < ActiveRecord::Migration
  def change
    create_table :plazr_store_shipment_condition_variants do |t|
    t.references :shipment_condition, :null => false
    t.references :variant, :null => false

    t.timestamps
    end
    add_index :plazr_store_shipment_condition_variants, [:shipment_condition_id, :variant_id], :unique => true, :name => 'index_shipment_condition_variant'
  end
end
