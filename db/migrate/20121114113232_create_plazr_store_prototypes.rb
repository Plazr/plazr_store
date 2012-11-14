class CreatePlazrStorePrototypes < ActiveRecord::Migration
  def change
    create_table :plazr_store_prototypes do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
