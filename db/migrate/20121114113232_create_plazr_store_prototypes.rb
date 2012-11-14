class CreatePlazrStorePrototypes < ActiveRecord::Migration
  def change
    create_table :plazr_store_prototypes do |t|
      t.string :name, :null => false
      t.boolean :active, :null => false, :default => true

      t.timestamps
    end
  end
end
