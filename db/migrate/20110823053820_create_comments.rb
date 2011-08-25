class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :user
      t.belongs_to :post
      t.boolean :is_valid, :default => true

      t.timestamps
    end
    add_index :comments, :post_id
  end
end
