class AddSettingsIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :setting_id, :integer
    add_index :images, :setting_id
  end
end
