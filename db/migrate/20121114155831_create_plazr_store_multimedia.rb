class CreatePlazrStoreMultimedia < ActiveRecord::Migration
  def change
    create_table :plazr_store_multimedia do |t|
      t.text :caption
      t.string     :class_type, :default => ""
      t.attachment :file
      t.references :variant

      t.timestamps
    end
    add_index :plazr_store_multimedia, :variant_id
  end
end
