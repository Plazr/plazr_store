class CreatePlazrStoreAddresses < ActiveRecord::Migration
  def change
    create_table :plazr_store_addresses do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :address1
      t.string :address2
      t.string :city
      t.string :zipcode
      t.string :phone
      t.string :alternative_phone
      t.string :company
      t.boolean :active, :null => false, :default => true

      t.timestamps
    end
    add_index :plazr_store_addresses, :first_name
    add_index :plazr_store_addresses, :last_name
  end
end
