class WishlistVariants < ActiveRecord::Migration
  def change
    create_table :plazr_store_wishlist_variants do |t|
    t.references :variant, :null => false
    t.references :wishlist, :null => false

    t.timestamps
    end
    add_index :plazr_store_wishlist_variants, [:variant_id, :wishlist_id], :unique => true, :name => 'index_variant_wishlist'
  end
end
