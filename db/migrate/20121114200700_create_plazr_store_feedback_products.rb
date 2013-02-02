class CreatePlazrStoreFeedbackProducts < ActiveRecord::Migration
  def change
    create_table :plazr_store_feedback_products do |t|
      t.text :comment
      t.integer :rating, :null => false
      t.references :user, :null => false
      t.references :product, :null => false
      t.references :order, :null => false

      t.timestamps
    end
    add_index :plazr_store_feedback_products, :user_id
    add_index :plazr_store_feedback_products, :product_id
  end
end
