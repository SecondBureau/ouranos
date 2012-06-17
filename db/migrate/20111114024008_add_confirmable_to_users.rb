class AddConfirmableToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      ## Confirmable
			t.string   :confirmation_token
			t.datetime :confirmed_at
			t.datetime :confirmation_sent_at
			t.string   :unconfirmed_email # Only if using reconfirmable
    end
    add_index :users, :confirmation_token, :unique => true
  end

  def self.down
    remove_column :users, :confirmable
  end
end
