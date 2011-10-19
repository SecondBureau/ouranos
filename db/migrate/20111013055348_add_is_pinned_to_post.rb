class AddIsPinnedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :is_pinned, :boolean, :default => false
  end
end
