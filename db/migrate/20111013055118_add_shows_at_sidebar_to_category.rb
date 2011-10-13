class AddShowsAtSidebarToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :shows_at_sidebar, :integer
  end
end
