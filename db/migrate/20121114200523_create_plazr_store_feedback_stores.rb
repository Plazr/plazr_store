class CreatePlazrStoreFeedbackStores < ActiveRecord::Migration
  def change
    create_table :plazr_store_feedback_stores do |t|
      t.text :comment
      t.decimal :rating
      t.references :user

      t.timestamps
    end
    add_index :plazr_store_feedback_stores, :user_id
  end
end
