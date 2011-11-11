class FixTypos < ActiveRecord::Migration
  def up
    rename_column :posts, :readed, :read_count
    remove_column :users, :is_expiried
    rename_column :users, :expiry_date, :expires_at
  end

  def down
    rename_column :posts, :read_count, :readed
    add_column :users, :is_expiried, :boolean
    rename_column :users, :expires_at, :expiry_date
  end
end

