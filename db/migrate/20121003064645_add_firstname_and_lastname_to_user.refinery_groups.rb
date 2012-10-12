# This migration comes from refinery_groups (originally 5)
class AddFirstnameAndLastnameToUser < ActiveRecord::Migration
  def change
    add_column :refinery_users, :firstname, :string
    add_column :refinery_users, :lastname, :string
  end
end
