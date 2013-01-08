class CreatePlazrStoreCoupons < ActiveRecord::Migration
  def change
    create_table :plazr_store_coupons do |t|
      t.references :user, :null => false
      t.references :promotional_code, :null => false

      t.timestamps
    end
    add_index :plazr_store_coupons, :promotional_code_id, :unique => true
    add_index :plazr_store_coupons, :user_id
  end
end
