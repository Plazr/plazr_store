class CreatePlazrStoreShipmentConditions < ActiveRecord::Migration
  def change
    create_table :plazr_store_shipment_conditions do |t|
      t.string :shipment_method, :null => false
      t.decimal :value, :precision => 8, :scale => 2
      t.boolean :active, :null => false, :default => true

      t.timestamps
    end
  end
end
