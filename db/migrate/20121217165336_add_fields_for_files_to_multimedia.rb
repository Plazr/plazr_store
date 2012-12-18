class AddFieldsForFilesToMultimedia < ActiveRecord::Migration
  def change
    change_table :plazr_store_multimedia do |t|
      t.remove :size, :link
      t.attachment :file
    end
  end
end
