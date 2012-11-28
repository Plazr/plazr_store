# This migration comes from plazr_auth (originally 20120827100337)
class AddUserData < ActiveRecord::Migration

  def connection
    PlazrAuth::User.connection
  end

  def up
    change_table :plazr_auth_users do |t|
      t.string  :first_name, :default => nil
      t.string  :last_name,  :default => nil
    end
  end

  def down
    change_table :plazr_auth_users do |t|
      t.remove :first_name
      t.remove :last_name
    end
  end
end
