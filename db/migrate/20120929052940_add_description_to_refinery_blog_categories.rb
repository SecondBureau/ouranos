class AddDescriptionToRefineryBlogCategories < ActiveRecord::Migration
  def change
    add_column :refinery_blog_categories, :description, :text
  end
end
