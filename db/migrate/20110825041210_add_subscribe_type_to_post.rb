class AddSubscribeTypeToPost < ActiveRecord::Migration
  def change
    add_column :posts, :can_be_subscribed, :boolean, :default => true
  end
end
