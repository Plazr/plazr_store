class CreatePlazrStoreCartVariants < ActiveRecord::Migration
  def change
    create_table :plazr_store_cart_variants do |t|
      t.integer :amount, :null => false, :default => 0
      t.integer :cart_id, :null => false
      t.integer :variant_id, :null => false

      t.timestamps
    end

    add_index :plazr_store_cart_variants, [:cart_id, :variant_id], :unique => true
  end
end
