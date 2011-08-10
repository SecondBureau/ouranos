class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :post_type
      t.belongs_to :user

      t.timestamps
    end
  end
end
