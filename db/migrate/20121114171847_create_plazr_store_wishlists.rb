class CreatePlazrStoreWishlists < ActiveRecord::Migration
  def change
    create_table :plazr_store_wishlists do |t|
      t.string :name
      t.boolean :is_private
      t.integer :user_id

      t.timestamps
    end

    add_index :plazr_store_wishlists, :user_id
  end
end
