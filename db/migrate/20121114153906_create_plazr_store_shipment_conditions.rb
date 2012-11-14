class CreatePlazrStoreShipmentConditions < ActiveRecord::Migration
  def change
    create_table :plazr_store_shipment_conditions do |t|
      t.string :shipment_method
      t.decimal :value
      t.boolean :active

      t.timestamps
    end
  end
end
