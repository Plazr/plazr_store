class PromotionVariants < ActiveRecord::Migration
  def change
    create_table :plazr_store_promotion_variants do |t|
    t.references :promotion, :null => false
    t.references :variant, :null => false

    t.timestamps
    end
    add_index :plazr_store_promotion_variants, [:promotion_id, :variant_id], :unique => true, :name => 'index_promotion_variant'
  end
end
