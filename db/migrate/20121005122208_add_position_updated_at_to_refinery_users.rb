class AddPositionUpdatedAtToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :position_updated_at, :datetime
  end
end
