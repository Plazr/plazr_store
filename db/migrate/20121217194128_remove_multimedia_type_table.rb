class RemoveMultimediaTypeTable < ActiveRecord::Migration
  def up
    drop_table :plazr_store_multimedia_type
    remove_index :plazr_store_multimedia, :multimedia_type_id
    remove_column :plazr_store_multimedia, :multimedia_type_id 
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
