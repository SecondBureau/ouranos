class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.integer :user_id
      t.text :params
      t.string :template
      t.string :token
      t.datetime :sent_at
      t.datetime :last_read_at
      t.integer :read_count, :default => 0

      t.timestamps
    end
  end
end
