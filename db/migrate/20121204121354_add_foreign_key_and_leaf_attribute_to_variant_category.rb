class AddForeignKeyAndLeafAttributeToVariantCategory < ActiveRecord::Migration
  def change
    add_column :plazr_store_variant_categories, :parent_variant_category_id, :integer
    add_column :plazr_store_variant_categories, :is_leaf, :boolean, :null => false, :default => false

    add_index :plazr_store_variant_categories, :parent_variant_category_id, :name => 'index_parent_variant_category_id'
  end
end
