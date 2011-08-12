source 'http://rubygems.org'

gem 'rails', '3.1.0.rc5'

gem 'json'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.1.0.rc"
  gem 'coffee-rails', "~> 3.1.0.rc"
  gem 'uglifier'
end

group :test do
  gem 'capybara'
  gem 'cucumber-rails'
  gem "database_cleaner"
end

gem 'rspec-rails', :group => [:development, :test]
gem 'sqlite3', :group => [:development, :test]
gem "ruby-debug", :group => [:development, :test]

gem "forgery"
gem 'machinist'


gem "acts_as_indexed"

gem "fastercsv"

gem "carrierwave"
gem 'rmagick'

gem "kaminari"

gem 'jquery-rails'

gem 'pdfkit'

gem 'heroku_s3_backup'
gem 'heroku_san'
gem 'heroku'

group :production do
  gem 'pg'
  gem 'therubyracer-heroku'
  gem "fog"
end

path "./vendor/gems" do
  gem "rorshack-permission"
  gem "rorshack-support"
  gem "rorshack-frontend"
  gem "rorshack-admin-ui"
  gem "rorshack-authentication"
  gem "rorshack"
end

