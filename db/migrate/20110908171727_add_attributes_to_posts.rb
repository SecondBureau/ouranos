class AddAttributesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :locale, :string
    add_column :posts, :meta_keywords, :string
    add_column :posts, :meta_description, :string
  end
end
