class CreatePlazrStoreMultimedia < ActiveRecord::Migration
  def change
    create_table :plazr_store_multimedia do |t|
      t.text :description
      t.integer :size
      t.text :link

      t.timestamps
    end
  end
end
