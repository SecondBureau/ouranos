# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ouranos::Application.initialize!

# default mailer
ActionMailer::Base.delivery_method = :smtp
