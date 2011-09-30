class CreateCategoriesPosts < ActiveRecord::Migration
  def change
    create_table :categories_posts, :id => false do |t|
      t.references :category, :null => false
      t.references :post, :null => false
    end
  end
end
