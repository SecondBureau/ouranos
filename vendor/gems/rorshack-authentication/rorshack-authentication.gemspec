# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rorshack-authentication}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{johnson of secondbureau}]
  s.date = %q{2011-07-25}
  s.description = %q{rorshack authentication}
  s.email = %q{johnson@secondbureau.com}
  s.files = [
    "app/assets/images/auth/facebook_32.png",
    "app/assets/images/auth/facebook_64.png",
    "app/assets/images/auth/google_32.png",
    "app/assets/images/auth/google_64.png",
    "app/assets/images/auth/linked_in_32.png",
    "app/assets/images/auth/linked_in_64.png",
    "app/assets/images/auth/open_id_32.png",
    "app/assets/images/auth/remove.png",
    "app/assets/images/auth/twitter_32.png",
    "app/assets/images/auth/twitter_64.png",
    "app/assets/javascripts/application.js",
    "app/assets/stylesheets/application.css",
    "app/controllers/rorshack_authentication/account_sessions_controller.rb",
    "app/controllers/rorshack_authentication/accounts_controller.rb",
    "app/controllers/rorshack_authentication/application_controller.rb",
    "app/controllers/rorshack_authentication/authentications_controller.rb",
    "app/controllers/rorshack_authentication/passwords_controller.rb",
    "app/helpers/mailers_helper.rb",
    "app/helpers/rorshack_authentication/application_helper.rb",
    "app/mailers/rorshack_authentication/user_notification.rb",
    "app/models/rorshack_authentication/account.rb",
    "app/models/rorshack_authentication/account_session.rb",
    "app/models/rorshack_authentication/authentication.rb",
    "app/models/rorshack_authentication/password.rb",
    "app/views/layouts/rorshack-authentication/application.html.erb",
    "app/views/rorshack_authentication/account_sessions/_form.html.haml",
    "app/views/rorshack_authentication/account_sessions/_omniauth.html.haml",
    "app/views/rorshack_authentication/account_sessions/new.html.haml",
    "app/views/rorshack_authentication/account_sessions/new.js.erb",
    "app/views/rorshack_authentication/accounts/_form.html.haml",
    "app/views/rorshack_authentication/accounts/_omniauth_connect.haml",
    "app/views/rorshack_authentication/accounts/edit.html.haml",
    "app/views/rorshack_authentication/accounts/new.html.haml",
    "app/views/rorshack_authentication/accounts/new.js.erb",
    "app/views/rorshack_authentication/passwords/edit.html.haml",
    "app/views/rorshack_authentication/passwords/new.html.haml",
    "app/views/rorshack_authentication/passwords/show.html.haml",
    "app/views/rorshack_authentication/user_notification/password_reset_notification.html.haml",
    "app/views/rorshack_authentication/user_notification/password_reset_notification.text.haml",
    "app/views/rorshack_authentication/user_notification/registration_notification.html.haml",
    "app/views/rorshack_authentication/user_notification/registration_notification.text.haml",
    "config/initializers/10-assets_pipeline.rb",
    "config/initializers/10-omniauth.rb",
    "config/initializers/10-rake_recapcha.rb",
    "config/routes.rb",
    "db/migrate/20110427065839_initial_authentication_tables.rb",
    "lib/extensions/action_controller_ext.rb",
    "lib/extensions/application_helper_ext.rb",
    "lib/rorshack-authentication.rb",
    "lib/rorshack-authentication/engine.rb",
    "lib/rorshack-authentication/version.rb",
    "lib/tasks/rorshack-authentication_tasks.rake"
  ]
  s.homepage = %q{http://github.com/johnson@secondbureau.com/rorshack-authentication}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{rorshack authentication}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.1.0.rc4"])
      s.add_runtime_dependency(%q<sqlite3>, [">= 0"])
      s.add_runtime_dependency(%q<jeweler>, [">= 0"])
      s.add_runtime_dependency(%q<rorshack-support>, [">= 0"])
      s.add_runtime_dependency(%q<rorshack-frontend>, [">= 0"])
      s.add_runtime_dependency(%q<omniauth>, [">= 0.2.6"])
      s.add_runtime_dependency(%q<authlogic>, [">= 0"])
      s.add_runtime_dependency(%q<haml-rails>, [">= 0"])
      s.add_runtime_dependency(%q<formtastic>, [">= 0"])
      s.add_runtime_dependency(%q<rack-recaptcha>, [">= 0"])
      s.add_runtime_dependency(%q<rspec-rails>, [">= 0"])
      s.add_runtime_dependency(%q<launchy>, [">= 0"])
      s.add_runtime_dependency(%q<database_cleaner>, [">= 0"])
      s.add_runtime_dependency(%q<forgery>, [">= 0"])
      s.add_runtime_dependency(%q<machinist>, ["= 1.0.6"])
      s.add_runtime_dependency(%q<rorshack-support>, [">= 0"])
      s.add_runtime_dependency(%q<rorshack-frontend>, [">= 0"])
      s.add_runtime_dependency(%q<omniauth>, [">= 0.2.6"])
      s.add_runtime_dependency(%q<authlogic>, [">= 3.0.3"])
      s.add_runtime_dependency(%q<haml-rails>, [">= 0.3.4"])
      s.add_runtime_dependency(%q<formtastic>, [">= 1.2.4"])
      s.add_runtime_dependency(%q<rails>, [">= 3.1.0.rc4"])
      s.add_runtime_dependency(%q<rack-recaptcha>, [">= 0.6.0"])
    else
      s.add_dependency(%q<rails>, [">= 3.1.0.rc4"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rorshack-support>, [">= 0"])
      s.add_dependency(%q<rorshack-frontend>, [">= 0"])
      s.add_dependency(%q<omniauth>, [">= 0.2.6"])
      s.add_dependency(%q<authlogic>, [">= 0"])
      s.add_dependency(%q<haml-rails>, [">= 0"])
      s.add_dependency(%q<formtastic>, [">= 0"])
      s.add_dependency(%q<rack-recaptcha>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<launchy>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
      s.add_dependency(%q<forgery>, [">= 0"])
      s.add_dependency(%q<machinist>, ["= 1.0.6"])
      s.add_dependency(%q<rorshack-support>, [">= 0"])
      s.add_dependency(%q<rorshack-frontend>, [">= 0"])
      s.add_dependency(%q<omniauth>, [">= 0.2.6"])
      s.add_dependency(%q<authlogic>, [">= 3.0.3"])
      s.add_dependency(%q<haml-rails>, [">= 0.3.4"])
      s.add_dependency(%q<formtastic>, [">= 1.2.4"])
      s.add_dependency(%q<rails>, [">= 3.1.0.rc4"])
      s.add_dependency(%q<rack-recaptcha>, [">= 0.6.0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.1.0.rc4"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rorshack-support>, [">= 0"])
    s.add_dependency(%q<rorshack-frontend>, [">= 0"])
    s.add_dependency(%q<omniauth>, [">= 0.2.6"])
    s.add_dependency(%q<authlogic>, [">= 0"])
    s.add_dependency(%q<haml-rails>, [">= 0"])
    s.add_dependency(%q<formtastic>, [">= 0"])
    s.add_dependency(%q<rack-recaptcha>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<launchy>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
    s.add_dependency(%q<forgery>, [">= 0"])
    s.add_dependency(%q<machinist>, ["= 1.0.6"])
    s.add_dependency(%q<rorshack-support>, [">= 0"])
    s.add_dependency(%q<rorshack-frontend>, [">= 0"])
    s.add_dependency(%q<omniauth>, [">= 0.2.6"])
    s.add_dependency(%q<authlogic>, [">= 3.0.3"])
    s.add_dependency(%q<haml-rails>, [">= 0.3.4"])
    s.add_dependency(%q<formtastic>, [">= 1.2.4"])
    s.add_dependency(%q<rails>, [">= 3.1.0.rc4"])
    s.add_dependency(%q<rack-recaptcha>, [">= 0.6.0"])
  end
end

