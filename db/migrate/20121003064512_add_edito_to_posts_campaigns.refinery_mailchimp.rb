# This migration comes from refinery_mailchimp (originally 4)

class AddEditoToPostsCampaigns < ActiveRecord::Migration

  def up
    add_column :refinery_mailchimp_posts_campaigns, :edito_id, :integer
  end

  def self.down
    remove_column :refinery_mailchimp_posts_campaigns, :edito_id, :integer
  end

end
