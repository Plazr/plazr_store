class CreatePlazrStoreAddresses < ActiveRecord::Migration
  def change
    create_table :plazr_store_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :zipcode
      t.string :phone
      t.string :alternative_phone
      t.string :company
      t.boolean :active

      t.timestamps
    end
  end
end
