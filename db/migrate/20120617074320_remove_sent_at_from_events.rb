class RemoveSentAtFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :sent_at
  end
end
