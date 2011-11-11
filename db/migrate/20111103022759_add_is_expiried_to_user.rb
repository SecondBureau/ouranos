class AddIsExpiriedToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_expiried, :boolean
  end
end

