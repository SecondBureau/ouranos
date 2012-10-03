Refinery::Groups.configure do |config|
  # Configure your Mailchimp API Key 
  config.api_key = $mailchimp_api_key
  
  config.list_id = $mailchimp_group_id 
end
