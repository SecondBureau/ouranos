# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ouranos::Application.initialize!

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'localhost',
  :authentication => :plain,
  :user_name => 'romain@secondbureau.com',
  :password => 'second$XL48'
}