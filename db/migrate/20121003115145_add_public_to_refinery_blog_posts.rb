class AddPublicToRefineryBlogPosts < ActiveRecord::Migration
  def change
    add_column Refinery::Blog::Post.table_name, :public, :boolean, :default => false
  end
end
