class CreatePlazrStoreCartVariants < ActiveRecord::Migration
  def change
    create_table :plazr_store_cart_variants do |t|
      t.integer :amount, :null => false, :default => 1
      t.integer :cart_id
      t.integer :variant_id

      t.timestamps
    end

    add_index :plazr_store_cart_variants, :cart_id
    add_index :plazr_store_cart_variants, :variant_id
  end
end
