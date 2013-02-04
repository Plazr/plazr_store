class CreatePlazrStoreBrands < ActiveRecord::Migration
  def change
    create_table :plazr_store_brands do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end
end
