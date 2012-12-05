class VariantVariantCategories < ActiveRecord::Migration
  def change
    create_table :plazr_store_variant_variant_categories do |t|
    t.references :variant, :null => false
    t.references :variant_category, :null => false

    t.timestamps
    end
    add_index :plazr_store_variant_variant_categories, [:variant_id, :variant_category_id], :unique => true, :name => 'index_variant_variant_category'
  end
end
