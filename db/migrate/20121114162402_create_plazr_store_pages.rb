class CreatePlazrStorePages < ActiveRecord::Migration
  def change
    create_table :plazr_store_pages do |t|
      t.string :title
      t.string :slug
      t.text :content

      t.timestamps
    end
    add_index :plazr_store_pages, :slug
  end
end
