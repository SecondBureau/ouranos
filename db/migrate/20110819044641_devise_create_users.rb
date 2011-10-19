class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.belongs_to :role, :null => false
      t.string :firstname, :null => false
      t.string :lastname, :null => false


      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :role_id
  end

  def self.down
    drop_table :users
  end
end
