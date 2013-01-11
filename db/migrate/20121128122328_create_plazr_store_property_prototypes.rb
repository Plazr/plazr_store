class CreatePlazrStorePropertyPrototypes < ActiveRecord::Migration
  def change
    create_table :plazr_store_property_prototypes do |t|
    t.references :property, :null => false
    t.references :prototype, :null => false

    t.timestamps
    end
    add_index :plazr_store_property_prototypes, [:property_id, :prototype_id], :unique => true, :name => 'index_property_prototype'
  end
end
