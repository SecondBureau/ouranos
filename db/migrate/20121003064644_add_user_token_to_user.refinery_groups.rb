# This migration comes from refinery_groups (originally 4)
# updated manually token => authentication_token
class AddUserTokenToUser < ActiveRecord::Migration
  def change
    add_column :refinery_users, :authentication_token, :string
  end
end
