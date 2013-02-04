class CreatePlazrStoreCarts < ActiveRecord::Migration
  def change
    create_table :plazr_store_carts do |t|
      t.integer :item_amount, :null => false, :default => 0
      t.decimal :total_price, :null => false, :default => 0, :precision => 8, :scale => 2
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :plazr_store_carts, :user_id
  end
end
