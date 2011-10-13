class ChangeShowsAtToBooleanOfCategories < ActiveRecord::Migration
  def up
    change_column :categories, :shows_at_home_page, :boolean
    change_column :categories, :shows_at_sidebar, :boolean
  end

  def down
    change_column :categories, :shows_at_home_page, :integer
    change_column :categories, :shows_at_sidebar, :integer
  end
end
