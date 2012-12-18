class CreatePlazrStoreMultimedia < ActiveRecord::Migration
  def change
    create_table :plazr_store_multimedia do |t|
      t.text :caption
      t.attachment :file
      t.references :variant
      t.references :page

      t.timestamps
    end
    add_index :plazr_store_multimedia, :variant_id
    add_index :plazr_store_multimedia, :page_id
  end
end
