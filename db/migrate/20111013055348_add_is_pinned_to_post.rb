class AddIsPinnedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :is_pinned, :integer
  end
end
