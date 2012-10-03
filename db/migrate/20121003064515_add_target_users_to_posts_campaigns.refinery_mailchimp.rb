# This migration comes from refinery_mailchimp (originally 7)

class AddTargetUsersToPostsCampaigns < ActiveRecord::Migration
  def self.up
    add_column :refinery_mailchimp_posts_campaigns, :target_users, :string
  end

  def self.down
    remove_column :refinery_mailchimp_posts_campaigns, :target_users
  end
end

