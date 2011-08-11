require File.expand_path('../boot', __FILE__)

require "pp"

require 'rails/all'
require 'thread'
require 'rake/dsl_definition'
require 'pdfkit'
# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Ouranos
  class Application < Rails::Application
#    include Rake::DSL
    config.time_zone = 'Paris'
    config.encoding = "utf-8"
    config.i18n.default_locale = :fr
    config.filter_parameters += [:password]
    
    config.middleware.use PDFKit::Middleware, :print_media_type => true

    # Enable the asset pipeline
    config.assets.enabled = true
  end
end