class CreatePlazrStoreUserGroups < ActiveRecord::Migration
  def change
    create_table :plazr_store_user_groups do |t|
      t.string :name, :null => false
      t.text :description

      t.timestamps
    end
  end
end
