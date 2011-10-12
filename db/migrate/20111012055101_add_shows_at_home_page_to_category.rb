class AddShowsAtHomePageToCategory < ActiveRecord::Migration
  def change
  	add_column :categories, :shows_at_home_page, :int
  end
end
