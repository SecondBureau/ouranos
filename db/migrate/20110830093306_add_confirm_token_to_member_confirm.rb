class AddConfirmTokenToMemberConfirm < ActiveRecord::Migration
  def change
    add_column :member_confirms, :token, :string
  end
end
