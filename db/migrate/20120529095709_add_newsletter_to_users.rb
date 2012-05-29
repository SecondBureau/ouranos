class AddNewsletterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :newsletter, :boolean, :default => 1
  end
end
