class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.belongs_to :user, :null => false
      t.string :permalink, :null => false

      t.timestamps
    end
    add_index :posts, :user_id
  end
end
