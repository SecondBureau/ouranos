class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :user
      t.boolean :is_valid, :default => true

      t.timestamps
    end
  end
end
