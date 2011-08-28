class CreateSubscribes < ActiveRecord::Migration
  def change
    create_table :subscribes do |t|
      t.belongs_to :user
      t.string :type
      t.integer :num_of_events
      t.integer :num_of_posts
      t.integer :cycle

      t.timestamps
    end
    add_index :subscribes, :user_id
  end
end
