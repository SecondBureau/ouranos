class AddNewsletterSentAtColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :newsletter_sent_at, :datetime
  end
end
