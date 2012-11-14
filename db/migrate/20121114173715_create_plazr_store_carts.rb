class CreatePlazrStoreCarts < ActiveRecord::Migration
  def change
    create_table :plazr_store_carts do |t|
      t.integer :item_amount
      t.decimal :total_price
      t.integer :user_id

      t.timestamps
    end

    add_index :plazr_store_carts, :user_id
  end
end
