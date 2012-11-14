class CreatePlazrStoreOrders < ActiveRecord::Migration
  def change
    create_table :plazr_store_orders do |t|
      t.string :email
      t.decimal :item_total
      t.decimal :adjustment_total
      t.decimal :total
      t.string :payment_state
      t.string :shipment_state
      t.datetime :completed_at
      t.string :state
      t.references :cart
      t.references :promotional_code
      t.references :coupon
      t.references :payment_data
      t.refererences :user
      t.integer :bill_address_id
      t.integer :ship_address_id

      t.timestamps
    end
    add_index :plazr_store_orders, :cart_id
    add_index :plazr_store_orders, :promotional_code_id
    add_index :plazr_store_orders, :coupon_id
    add_index :plazr_store_orders, :payment_data_id
    add_index :plazr_store_orders, :bill_address_id
    add_index :plazr_store_orders, :ship_address_id
  end
end
