# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rorshack-admin-ui}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{johnson of secondbureau}]
  s.date = %q{2011-07-25}
  s.description = %q{rorshack admin-ui}
  s.email = %q{johnson@secondbureau.com}
  s.files = [
    "app/assets/images/rorshack_admin_ui/down_arrow.gif",
    "app/assets/images/rorshack_admin_ui/jquery.wysiwyg.bg.png",
    "app/assets/images/rorshack_admin_ui/jquery.wysiwyg.gif",
    "app/assets/images/rorshack_admin_ui/up_arrow.gif",
    "app/assets/javascripts/application.js",
    "app/assets/javascripts/controls/wysiwyg.colorpicker.js",
    "app/assets/javascripts/controls/wysiwyg.cssWrap.js",
    "app/assets/javascripts/controls/wysiwyg.image.js.erb",
    "app/assets/javascripts/controls/wysiwyg.link.js",
    "app/assets/javascripts/controls/wysiwyg.table.js",
    "app/assets/javascripts/jquery.wysiwyg.js",
    "app/assets/javascripts/rorshack_admin_ui/admin.js",
    "app/assets/javascripts/rorshack_admin_ui/admin_ui.js",
    "app/assets/javascripts/rorshack_admin_ui/jwysiwyg.js",
    "app/assets/stylesheets/application.css",
    "app/assets/stylesheets/jquery.wysiwyg.css",
    "app/assets/stylesheets/rorshack_admin_ui/admin.css.scss",
    "app/assets/stylesheets/rorshack_admin_ui/admin_formtastic.css.scss",
    "app/assets/stylesheets/rorshack_admin_ui/admin_layout.css.scss",
    "app/assets/stylesheets/rorshack_admin_ui/admin_ui.css",
    "app/controllers/rorshack_admin_ui/admin_controller.rb",
    "app/controllers/rorshack_admin_ui/admin_ui_controller.rb",
    "app/controllers/rorshack_admin_ui/application_controller.rb",
    "app/helpers/application_helper.rb",
    "app/helpers/rorshack_admin_ui/admin_helper.rb",
    "app/helpers/rorshack_admin_ui/admin_ui_helper.rb",
    "app/helpers/rorshack_admin_ui/application_helper.rb",
    "app/uploaders/admin_images_uploader.rb",
    "app/views/layouts/rorshack-admin-ui/application.html.erb",
    "app/views/rorshack_admin_ui/admin/list.html.haml",
    "config/initializers/10-carmen.rb",
    "config/initializers/10-carrierwave.rb",
    "config/initializers/admin_ui_scss.rb",
    "config/initializers/kaminari_config.rb",
    "config/initializers/load_helper_path.rb",
    "config/routes.rb",
    "lib/generators/rorshack/admin_ui/views/USAGE",
    "lib/generators/rorshack/admin_ui/views/templates/admin_ui/_collection_table.html.haml",
    "lib/generators/rorshack/admin_ui/views/templates/admin_ui/_edit_navigation.html.haml",
    "lib/generators/rorshack/admin_ui/views/templates/admin_ui/_form.html.haml",
    "lib/generators/rorshack/admin_ui/views/templates/admin_ui/_index_navigation.html.haml",
    "lib/generators/rorshack/admin_ui/views/templates/admin_ui/_new_navigation.html.haml",
    "lib/generators/rorshack/admin_ui/views/templates/admin_ui/_resource_detail.html.haml",
    "lib/generators/rorshack/admin_ui/views/templates/admin_ui/_search_collection.html.haml",
    "lib/generators/rorshack/admin_ui/views/templates/admin_ui/_show_navigation.html.haml",
    "lib/generators/rorshack/admin_ui/views/templates/admin_ui/edit.html.haml",
    "lib/generators/rorshack/admin_ui/views/templates/admin_ui/index.html.haml",
    "lib/generators/rorshack/admin_ui/views/templates/admin_ui/index.js.erb",
    "lib/generators/rorshack/admin_ui/views/templates/admin_ui/new.html.haml",
    "lib/generators/rorshack/admin_ui/views/templates/admin_ui/show.html.haml",
    "lib/generators/rorshack/admin_ui/views/templates/admin_ui/show.js.erb",
    "lib/generators/rorshack/admin_ui/views/views_generator.rb",
    "lib/rorshack-admin-ui.rb",
    "lib/rorshack-admin-ui/engine.rb",
    "lib/rorshack-admin-ui/inherited_resources_ext.rb",
    "lib/rorshack-admin-ui/version.rb",
    "lib/tasks/rorshack-admin-ui_tasks.rake"
  ]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{rorshack admin-ui}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["= 3.1.0.rc4"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
      s.add_runtime_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<jeweler>, [">= 0"])
      s.add_runtime_dependency(%q<sqlite3>, [">= 0"])
      s.add_runtime_dependency(%q<carmen>, [">= 0"])
      s.add_runtime_dependency(%q<rorshack-support>, [">= 0"])
      s.add_runtime_dependency(%q<rorshack-frontend>, [">= 0"])
      s.add_runtime_dependency(%q<rorshack-authentication>, [">= 0"])
      s.add_runtime_dependency(%q<rorshack-permission>, [">= 0"])
      s.add_runtime_dependency(%q<inherited_resources>, ["~> 1.2.1"])
      s.add_runtime_dependency(%q<inherited_resources_views>, [">= 0"])
      s.add_runtime_dependency(%q<carrierwave>, [">= 0"])
      s.add_runtime_dependency(%q<rspec-rails>, [">= 0"])
      s.add_runtime_dependency(%q<database_cleaner>, [">= 0"])
      s.add_runtime_dependency(%q<forgery>, [">= 0"])
      s.add_runtime_dependency(%q<machinist>, ["= 1.0.6"])
      s.add_runtime_dependency(%q<rails>, [">= 0"])
      s.add_runtime_dependency(%q<rorshack-support>, [">= 0"])
      s.add_runtime_dependency(%q<rorshack-frontend>, [">= 0"])
      s.add_runtime_dependency(%q<rorshack-authentication>, [">= 0"])
      s.add_runtime_dependency(%q<rorshack-permission>, [">= 0"])
      s.add_runtime_dependency(%q<inherited_resources>, [">= 1.2.2"])
      s.add_runtime_dependency(%q<inherited_resources_views>, [">= 0"])
      s.add_runtime_dependency(%q<kaminari>, [">= 0"])
      s.add_runtime_dependency(%q<carmen>, [">= 0"])
    else
      s.add_dependency(%q<rails>, ["= 3.1.0.rc4"])
      s.add_dependency(%q<jquery-rails>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<carmen>, [">= 0"])
      s.add_dependency(%q<rorshack-support>, [">= 0"])
      s.add_dependency(%q<rorshack-frontend>, [">= 0"])
      s.add_dependency(%q<rorshack-authentication>, [">= 0"])
      s.add_dependency(%q<rorshack-permission>, [">= 0"])
      s.add_dependency(%q<inherited_resources>, ["~> 1.2.1"])
      s.add_dependency(%q<inherited_resources_views>, [">= 0"])
      s.add_dependency(%q<carrierwave>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
      s.add_dependency(%q<forgery>, [">= 0"])
      s.add_dependency(%q<machinist>, ["= 1.0.6"])
      s.add_dependency(%q<rails>, [">= 0"])
      s.add_dependency(%q<rorshack-support>, [">= 0"])
      s.add_dependency(%q<rorshack-frontend>, [">= 0"])
      s.add_dependency(%q<rorshack-authentication>, [">= 0"])
      s.add_dependency(%q<rorshack-permission>, [">= 0"])
      s.add_dependency(%q<inherited_resources>, [">= 1.2.2"])
      s.add_dependency(%q<inherited_resources_views>, [">= 0"])
      s.add_dependency(%q<kaminari>, [">= 0"])
      s.add_dependency(%q<carmen>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, ["= 3.1.0.rc4"])
    s.add_dependency(%q<jquery-rails>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<carmen>, [">= 0"])
    s.add_dependency(%q<rorshack-support>, [">= 0"])
    s.add_dependency(%q<rorshack-frontend>, [">= 0"])
    s.add_dependency(%q<rorshack-authentication>, [">= 0"])
    s.add_dependency(%q<rorshack-permission>, [">= 0"])
    s.add_dependency(%q<inherited_resources>, ["~> 1.2.1"])
    s.add_dependency(%q<inherited_resources_views>, [">= 0"])
    s.add_dependency(%q<carrierwave>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
    s.add_dependency(%q<forgery>, [">= 0"])
    s.add_dependency(%q<machinist>, ["= 1.0.6"])
    s.add_dependency(%q<rails>, [">= 0"])
    s.add_dependency(%q<rorshack-support>, [">= 0"])
    s.add_dependency(%q<rorshack-frontend>, [">= 0"])
    s.add_dependency(%q<rorshack-authentication>, [">= 0"])
    s.add_dependency(%q<rorshack-permission>, [">= 0"])
    s.add_dependency(%q<inherited_resources>, [">= 1.2.2"])
    s.add_dependency(%q<inherited_resources_views>, [">= 0"])
    s.add_dependency(%q<kaminari>, [">= 0"])
    s.add_dependency(%q<carmen>, [">= 0"])
  end
end

