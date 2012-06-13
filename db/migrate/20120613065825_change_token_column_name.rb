class ChangeTokenColumnName < ActiveRecord::Migration
  def up
    rename_column :users, :token_authenticatable, :authentication_token
  end

  def down
  end
end
