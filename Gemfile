source 'http://rubygems.org'

#migrating to rails 3.2.2 (GCRO 15/06/2012)
gem 'rails', '3.2.2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'pry'
  gem 'heroku_san'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'growl'
  gem 'libnotify'
  gem 'foreman'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec'
  gem 'rspec-rails'
end

group :production do
  gem 'therubyracer-heroku'
  gem 'fog'
  #DBMS
  gem 'pg'
  #monitoring
  gem 'newrelic_rpm'
  gem 'restful_metrics'
end

# Coding
gem 'coffee-filter'
gem 'haml-rails'
gem 'jquery-rails'
gem 'tinymce-rails'
gem 'formtastic'

# Rendering
gem 'draper'
gem 'cells'
gem 'RedCloth'

# Storage
gem "paperclip"
gem "aws-s3"
gem 'right_aws', '>= 2.0.0'

# performances
gem 'dalli'
gem 'thin'

# administration
gem 'rails_admin', :git => 'git://github.com/mark-secondbureau/rails_admin_ape.git'

# authorizing
gem 'cancan'
gem 'devise'

# emailing
gem 'hpricot'
gem 'htmlentities'
gem 'premailer-rails3'

# others (deprecated ?)
gem "kaminari"
gem 'ruby_parser'
gem 'meta_search'
gem 'rack-cache'
