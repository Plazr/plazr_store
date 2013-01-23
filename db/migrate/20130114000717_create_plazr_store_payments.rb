class CreatePlazrStorePayments < ActiveRecord::Migration
  def change
    create_table :plazr_store_payments do |t|
      t.float :total
      t.string :state
      t.references :order
      t.references :payment_method

      t.timestamps
    end
    add_index :plazr_store_payments, :order_id
    add_index :plazr_store_payments, :payment_method_id
  end
end
