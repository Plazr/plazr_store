class CreatePlazrStoreStoreCategories < ActiveRecord::Migration
  def change
    create_table :plazr_store_store_categories do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
