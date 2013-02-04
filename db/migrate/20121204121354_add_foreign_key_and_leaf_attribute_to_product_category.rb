class AddForeignKeyAndLeafAttributeToProductCategory < ActiveRecord::Migration
  def change
    add_column :plazr_store_product_categories, :parent_product_category_id, :integer
    add_column :plazr_store_product_categories, :is_leaf, :boolean, :null => false, :default => false

    add_index :plazr_store_product_categories, :parent_product_category_id, :name => 'index_parent_product_category_id'
  end
end
