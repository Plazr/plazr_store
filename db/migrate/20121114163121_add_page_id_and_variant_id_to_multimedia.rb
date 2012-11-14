class AddPageIdAndVariantIdToMultimedia < ActiveRecord::Migration
  def change
    add_column :plazr_store_multimedia, :page_id, :integer
    add_column :plazr_store_multimedia, :variant_id, :integer

    add_index :plazr_store_multimedia, :page_id
    add_index :plazr_store_multimedia, :variant_id
  end
end
