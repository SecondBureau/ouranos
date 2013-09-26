source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '3.2.14'

#DBMS
gem 'pg'

group :development do
 gem 'foreman'
 gem 'taps'
 gem 'pry'
 gem "better_errors"
 gem "binding_of_caller"
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails', :require => false
  gem 'capybara'
  gem 'guard-rspec'
  #gem 'launchy'
  #gem 'growl'
  #gem 'ruby-growl'
  #gem 'libnotify'
end

group :production do
 gem 'newrelic_rpm'
 gem 'fog'
 gem 'rack-cache'
 gem 'memcachier'
 gem 'dalli'
 gem 'kgio'
 gem 'rails_12factor'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

# editing-rendering
gem 'haml-rails',   '~> 0.3.5'
gem 'coffee-filter' #Integrated in haml 4.0
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 2.0.3'
gem "twitter-bootstrap-rails", '2.2.6' #Twitter-bootstrap-rails has a very big issue with versioning - Generator between 2.2.6 and 2.2.7 changed.
gem 'bootstrap-will_paginate'
gem 'jquery-ui-rails'
gem 'bourbon'
gem 'nokogiri'
gem 'sanitize'
gem 'deface'
gem 'less-rails', '2.3.3' #https://github.com/metaskills/less-rails/issues/71

# PDF Export
#gem "doc_raptor"

# Excel
#gem 'roo'

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
gem "refinerycms-settings", "2.0.1"
gem 'refinerycms-inquiries', '~> 2.0.0'
#  gem 'refinerycms-search', '~> 2.0.0'

gem 'gibbon', '~> 0.4.6' #Gibbon 0.5.0+ targets MailChimp API 2.0, which is substantially different from API 1.3. Please use Gibbon 0.4.6 if you need to use API 1.3.
gem 'refinerycms-mailchimp', :git => 'git://github.com/mark-secondbureau/refinerycms-mailchimp.git'
gem 'refinerycms-groups', :git => 'git://github.com/mark-secondbureau/refinerycms-groups.git'
