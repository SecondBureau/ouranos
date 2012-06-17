
Devise.setup do |config|

  config.mailer_sender = "ape-lfip@ape-pekin.com"

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [ :email ]
  
  config.strip_whitespace_keys = [ :email ]

  config.stretches = 10

  config.reset_password_within = 2.hours

  config.sign_out_via = :delete
  
  config.token_authentication_key = :auth_token

end
