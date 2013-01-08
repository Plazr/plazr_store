class CreatePlazrStoreProductCategories < ActiveRecord::Migration
  def change
    create_table :plazr_store_product_categories do |t|
      t.string :name, :null => false
      t.text :description

      t.timestamps
    end
  end
end
