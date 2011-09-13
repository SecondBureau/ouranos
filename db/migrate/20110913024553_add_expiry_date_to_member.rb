class AddExpiryDateToMember < ActiveRecord::Migration
  def change
    add_column :users, :expiry_date, :datetime
  end
end
