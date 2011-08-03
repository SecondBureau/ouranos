class AddUserToComment < ActiveRecord::Migration
  def change
    add_column :comments, :user, :belongs_to
  end
end
