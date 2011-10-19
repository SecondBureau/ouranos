class AddShowsAtToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :shows_at, :string, :default => "left"
  end
end
