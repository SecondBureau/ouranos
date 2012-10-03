source 'https://rubygems.org'

gem 'rails', '3.2.8'

#DBMS
gem 'pg'

group :development do
 gem 'foreman'
 gem 'heroku'
 gem 'heroku_san'
 gem 'taps'
 gem 'pry'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails', :require => false
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'growl'
  #gem 'ruby-growl'
  gem 'libnotify'
end

group :production, :demo do
 gem 'newrelic_rpm'
 gem 'fog'
 gem 'memcachier'
 gem 'dalli'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

# editing-rendering
gem 'haml-rails'
gem 'coffee-filter'
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 2.0.3'
gem "twitter-bootstrap-rails"
gem 'bootstrap-will_paginate'
gem 'jquery-ui-rails'
gem 'bourbon'
gem 'nokogiri'
gem 'sanitize'
gem 'deface'

# PDF Export
gem "doc_raptor"

# Excel
gem 'roo'

# Performances
gem 'thin'
gem 'bullet', group: :development

# Refinery CMS
gem 'refinerycms', '~> 2.0.0'

# Refinery CMS Extensions
gem 'refinerycms-i18n', '~> 2.0.0'
gem 'refinerycms-blog', '~> 2.0.0'
gem 'refinerycms-page-images', '~> 2.0.0'
gem 'refinerycms-calendar', :git => 'git://github.com/haroldt/refinerycms-calendar.git'
gem "refinerycms-settings", "~> 2.0.1"

#  gem 'refinerycms-inquiries', '~> 2.0.0'
#  gem 'refinerycms-search', '~> 2.0.0'

gem 'gibbon'
gem 'refinerycms-mailchimp', :git => 'git://github.com/mark-secondbureau/refinerycms-mailchimp.git'
gem 'refinerycms-groups', :git => 'git://github.com/mark-secondbureau/refinerycms-groups.git'