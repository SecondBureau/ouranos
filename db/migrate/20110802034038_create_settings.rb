class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings, :force => true do |t|
      t.string  :name
      t.string  :value
      t.string  :locale
      t.string  :tooltip
      t.boolean :admin_only, :default => false, :null => false
      t.timestamps
    end
    add_index :settings, [:name, :locale], :unique => true
  end
end
