class AddValidtagToComment < ActiveRecord::Migration
  def change
    add_column :comments, :validtag, :boolean
  end
end
