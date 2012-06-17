class AddSentAtColumnToPostEvent < ActiveRecord::Migration
  def change
    add_column :posts, :sent_at, :datetime
    add_column :events, :sent_at, :datetime
  end
end
