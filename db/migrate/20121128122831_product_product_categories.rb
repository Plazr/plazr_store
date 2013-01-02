class ProductProductCategories < ActiveRecord::Migration
  def change
    create_table :plazr_store_product_product_categories do |t|
    t.references :product, :null => false
    t.references :product_category, :null => false

    t.timestamps
    end
    add_index :plazr_store_product_product_categories, [:product_id, :product_category_id], :unique => true, :name => 'index_product_product_category'
  end
end
