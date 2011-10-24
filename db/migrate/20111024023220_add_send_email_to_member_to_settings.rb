class AddSendEmailToMemberToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :send_email_after_user_created, :boolean, :default => false
  end
end
