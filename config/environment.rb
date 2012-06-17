# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ouranos::Application.initialize!

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => false,
  :address => 'caffeine.2bu.ro',
  :port => 25,
  :domain => 'maille.com',
  :authentication => :plain,
  :user_name => 'smtpsender@2bu.ro',
  :password => 'secret11'
}
