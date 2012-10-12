require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Ouranos
  class Application < Rails::Application

    # locale & Timezone
    config.i18n.fallbacks = true
    config.i18n.default_locale = :fr
    config.time_zone = 'Beijing'

    # emails
    config.host = ENV['host'] || 'localhost:3000'
    config.action_mailer.default_url_options = { :host =>  config.host }
    config.action_mailer.asset_host = "http://" +  config.host

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true
    
    # https://devcenter.heroku.com/articles/labs-user-env-compile
    # heroku labs:enable user-env-compile -a myapp
    config.assets.initialize_on_precompile = true
    
    

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
end
