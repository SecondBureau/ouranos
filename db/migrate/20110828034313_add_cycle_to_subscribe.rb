class AddCycleToSubscribe < ActiveRecord::Migration
  def change
    add_column :subscribes, :cycle, :integer
  end
end
