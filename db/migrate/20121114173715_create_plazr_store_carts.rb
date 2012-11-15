class CreatePlazrStoreCarts < ActiveRecord::Migration
  def change
    create_table :plazr_store_carts do |t|
      t.integer :item_amount, :null => false, :default => 0
      t.decimal :total_price, :null => false
      t.integer :user_id

      t.timestamps
    end

    add_index :plazr_store_carts, :user_id
  end
end
