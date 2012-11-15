class CreatePlazrStorePaymentData < ActiveRecord::Migration
  def change
    create_table :plazr_store_payment_data do |t|
      t.decimal :total
      t.text :payment_data
      t.string :state
      t.references :user
      t.references :payment_method
      t.integer :bill_address_id
      t.integer :ship_address_id

      t.timestamps
    end
    add_index :plazr_store_payment_data, :user_id
    add_index :plazr_store_payment_data, :payment_method_id
    add_index :plazr_store_payment_data, :bill_address_id
    add_index :plazr_store_payment_data, :ship_address_id
  end
end
