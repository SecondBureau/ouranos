class AddOptinNewslettersToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :optin_newsletters, :boolean, :default => false
  end
end
