class CreatePlazrStoreOrders < ActiveRecord::Migration
  def change
    create_table :plazr_store_orders do |t|
      t.string :email, :null => false
      t.decimal :item_total, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.decimal :adjustment_total, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.decimal :total, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.string :payment_state, :null => false
      t.string :shipment_state, :null => false
      t.datetime :completed_at
      t.string :state, :null => false
      t.references :cart, :null => false
      t.references :promotional_code
      t.references :coupon
      t.references :payment_data, :null => false
      t.references :user, :null => false
      t.integer :bill_address_id
      t.integer :ship_address_id

      t.integer :shipment_condition_id

      t.timestamps
    end
    add_index :plazr_store_orders, :cart_id
    add_index :plazr_store_orders, :promotional_code_id
    add_index :plazr_store_orders, :coupon_id
    add_index :plazr_store_orders, :payment_data_id
    add_index :plazr_store_orders, :user_id
    add_index :plazr_store_orders, :bill_address_id
    add_index :plazr_store_orders, :ship_address_id

    add_index :plazr_store_orders, :shipment_condition_id
  end
end
