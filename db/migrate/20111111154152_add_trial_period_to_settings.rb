class AddTrialPeriodToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :trial_period, :integer
  end
end
