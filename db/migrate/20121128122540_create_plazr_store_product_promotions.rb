class CreatePlazrStoreProductPromotions < ActiveRecord::Migration
  def change
    create_table :plazr_store_product_promotions do |t|
    t.references :product, :null => false
    t.references :promotion, :null => false

    t.timestamps
    end
    add_index :plazr_store_product_promotions, [:product_id, :promotion_id], :unique => true, :name => 'index_product_promotion'
  end
end
