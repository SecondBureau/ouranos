class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :post
      t.belongs_to :user
      t.integer :is_valid

      t.timestamps
    end
  end
end
