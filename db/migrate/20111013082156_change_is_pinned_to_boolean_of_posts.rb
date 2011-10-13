class ChangeIsPinnedToBooleanOfPosts < ActiveRecord::Migration
  def up
    change_column :posts, :is_pinned, :boolean
  end

  def down
    change_column :posts, :is_pinned, :integer
  end
end
