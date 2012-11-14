class AddPageIdAndVariantIdToMultimedia < ActiveRecord::Migration
  def change
    add_column :multimedia, :page_id, :integer
    add_column :multimedia, :variant_id, :integer

    add_index :multimedia, :page_id
    add_index :multimedia, :variant_id
  end
end
