class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.text :content
      t.belongs_to :user

      t.timestamps
    end
    add_index :messages, :user_id
  end
end
