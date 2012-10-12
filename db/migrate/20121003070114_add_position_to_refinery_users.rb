class AddPositionToRefineryUsers < ActiveRecord::Migration
  def change
    add_column Refinery::User.table_name, :position, :string
  end
end

