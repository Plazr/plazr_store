class CreatePlazrStoreVariantWishlists < ActiveRecord::Migration
  def change
    create_table :plazr_store_variant_wishlists do |t|
    t.references :variant, :null => false
    t.references :wishlist, :null => false

    t.timestamps
    end
    add_index :plazr_store_variant_wishlists, [:variant_id, :wishlist_id], :unique => true, :name => 'index_variant_wishlist'
  end
end
