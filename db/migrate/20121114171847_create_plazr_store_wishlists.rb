class CreatePlazrStoreWishlists < ActiveRecord::Migration
  def change
    create_table :plazr_store_wishlists do |t|
      t.string :name, :null => false, :default => 'wishlist'
      t.boolean :is_private, :null => false, :default => true
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :plazr_store_wishlists, :user_id
  end
end
