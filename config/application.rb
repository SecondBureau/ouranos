require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the default gems, the ones in the
# current environment and also include :assets gems if in development
# or test environments.
Bundler.require *Rails.groups(:assets) if defined?(Bundler)

module Ouranos
  class Application < Rails::Application
    
    config.action_mailer.default_url_options = { :host => "localhost:3008" }
    
    # Configure the layout of the Devise on sign in and sign up and forget password pages
    config.to_prepare do
      Devise::SessionsController.layout "sign"
      Devise::RegistrationsController.layout "sign"
      Devise::PasswordsController.layout "sign"
    end
    
    config.i18n.fallbacks = true
    config.i18n.default_locale = :fr

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true
    config.assets.initialize_on_precompile = false
  end
end
