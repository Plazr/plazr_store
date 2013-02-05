class AddDeletedAtToAllTables < ActiveRecord::Migration
  def change
    tables = ActiveRecord::Base.connection.tables - ["schema_migrations"]
    tables.each do |table|
        add_column table, :deleted_at, :datetime
    end
  end
end
