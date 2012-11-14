class CreatePlazrStoreProperties < ActiveRecord::Migration
  def change
    create_table :plazr_store_properties do |t|
      t.string :name_id
      t.string :name_display
      t.boolean :active

      t.timestamps
    end
  end
end
