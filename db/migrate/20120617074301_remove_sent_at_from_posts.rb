class RemoveSentAtFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :sent_at
  end
end
