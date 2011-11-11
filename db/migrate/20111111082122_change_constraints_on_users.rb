class ChangeConstraintsOnUsers < ActiveRecord::Migration
  def up
    #change_column :users, :firstname, :string, :null => true
    #change_column :users, :lastname, :string, :null => true
  end

  def down
   #change_column :users, :firstname, :string, :null => false, :default => ""
    #change_column :users, :lastname, :string, :null => false, :default => ""
  end
end

