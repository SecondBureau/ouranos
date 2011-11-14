# Use this hook to configure devise mailer, warden hooks and so forth. The first
# four configuration values can also be set straight in your models.
Devise.setup do |config|

  config.to_prepare do
    Devise::Mailer.layout "devise"
  end
  config.mailer_sender = "ape-lfip@ape-pekin.com"

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [ :email ]
  
  config.strip_whitespace_keys = [ :email ]

  config.stretches = 10

  config.use_salt_as_remember_token = true

  config.reset_password_within = 2.hours

  config.sign_out_via = :delete

  # ==> OmniAuth
  # Add a new OmniAuth provider. Check the wiki for more information on setting
  # up on your models and hooks.
  # config.omniauth :github, 'APP_ID', 'APP_SECRET', :scope => 'user,public_repo'

  # ==> Warden configuration
  # If you want to use other strategies, that are not supported by Devise, or
  # change the failure app, you can configure them inside the config.warden block.
  #
  # config.warden do |manager|
  #   manager.failure_app   = AnotherApp
  #   manager.intercept_401 = false
  #   manager.default_strategies(:scope => :user).unshift :some_external_strategy
  # end
end
