class CreatePlazrStoreShipmentConditions < ActiveRecord::Migration
  def change
    create_table :plazr_store_shipment_conditions do |t|
      t.string :shipment_method, :null => false
      t.decimal :value, :precision => 8, :scale => 2, :default => 0
      # t.datetime :deleted_at

      t.timestamps
    end
  end
end
