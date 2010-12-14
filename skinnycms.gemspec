# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{skinnycms}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["RuslanHamidullin"]
  s.date = %q{2010-12-14}
  s.description = %q{long description}
  s.email = %q{ruslan.hamidullin@flatsoft.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "app/controllers/admin/pages_controller.rb",
    "app/models/page.rb",
    "app/models/page_content.rb",
    "app/views/admin/pages/_page_list.html.erb",
    "app/views/admin/pages/edit.html.erb",
    "app/views/admin/pages/index.html.erb",
    "app/views/admin/pages/new.html.erb",
    "app/views/admin/pages/show.html.erb",
    "config/routes.rb",
    "init.rb",
    "lib/generators/skinnycms_cucumber_features/USAGE",
    "lib/generators/skinnycms_cucumber_features/features_templates/features/factories.rb",
    "lib/generators/skinnycms_cucumber_features/features_templates/features/skinnycms/CRUD_methods_for_pages_in_admin_panel.feature",
    "lib/generators/skinnycms_cucumber_features/features_templates/features/skinnycms/pages_reordering_in_admin_panel.feature",
    "lib/generators/skinnycms_cucumber_features/features_templates/features/skinnycms/view_pages_settings_in_admin_panel.feature",
    "lib/generators/skinnycms_cucumber_features/features_templates/features/step_definitions/skinnycms/admin_pages_steps.rb",
    "lib/generators/skinnycms_cucumber_features/features_templates/features/step_definitions/skinnycms/authentication_steps.rb",
    "lib/generators/skinnycms_cucumber_features/skinnycms_cucumber_features_generator.rb",
    "lib/generators/skinnycms_images/USAGE",
    "lib/generators/skinnycms_images/skinnycms_images_generator.rb",
    "lib/generators/skinnycms_javascripts/USAGE",
    "lib/generators/skinnycms_javascripts/skinnycms_javascripts_generator.rb",
    "lib/generators/skinnycms_migrations/USAGE",
    "lib/generators/skinnycms_migrations/skinnycms_migrations_generator.rb",
    "lib/generators/skinnycms_migrations/templates/create_page_contents.rb",
    "lib/generators/skinnycms_migrations/templates/create_pages.rb",
    "lib/generators/skinnycms_styles/USAGE",
    "lib/generators/skinnycms_styles/skinnycms_styles_generator.rb",
    "lib/skinnycms.rb",
    "lib/skinnycms/engine.rb",
    "lib/skinnycms/railties/tasks.rake",
    "public/images/sortable_icons/minus.jpg",
    "public/images/sortable_icons/plus.jpg",
    "public/images/sortable_icons/skrepka.jpg",
    "public/javasripts/nestedSortable.1.2.1/jquery-1.4.2.min.js",
    "public/javasripts/nestedSortable.1.2.1/jquery-ui-1.8.2.custom.min.js",
    "public/javasripts/nestedSortable.1.2.1/jquery.ui.nestedSortable.js",
    "public/stylesheets/admin.css",
    "public/stylesheets/nestedSortable.css",
    "skinnycms.gemspec",
    "spec/models/page_content_spec.rb",
    "spec/models/page_spec.rb",
    "spec/rails_3_0_3_root/.gitignore",
    "spec/rails_3_0_3_root/.rspec",
    "spec/rails_3_0_3_root/.rvmrc",
    "spec/rails_3_0_3_root/Gemfile",
    "spec/rails_3_0_3_root/Gemfile.lock",
    "spec/rails_3_0_3_root/README",
    "spec/rails_3_0_3_root/Rakefile",
    "spec/rails_3_0_3_root/app/controllers/application_controller.rb",
    "spec/rails_3_0_3_root/app/helpers/application_helper.rb",
    "spec/rails_3_0_3_root/app/views/layouts/application.html.erb",
    "spec/rails_3_0_3_root/autotest/discover.rb",
    "spec/rails_3_0_3_root/config.ru",
    "spec/rails_3_0_3_root/config/application.rb",
    "spec/rails_3_0_3_root/config/boot.rb",
    "spec/rails_3_0_3_root/config/cucumber.yml",
    "spec/rails_3_0_3_root/config/database.yml",
    "spec/rails_3_0_3_root/config/environment.rb",
    "spec/rails_3_0_3_root/config/environments/development.rb",
    "spec/rails_3_0_3_root/config/environments/production.rb",
    "spec/rails_3_0_3_root/config/environments/test.rb",
    "spec/rails_3_0_3_root/config/initializers/backtrace_silencers.rb",
    "spec/rails_3_0_3_root/config/initializers/inflections.rb",
    "spec/rails_3_0_3_root/config/initializers/mime_types.rb",
    "spec/rails_3_0_3_root/config/initializers/secret_token.rb",
    "spec/rails_3_0_3_root/config/initializers/session_store.rb",
    "spec/rails_3_0_3_root/config/locales/en.yml",
    "spec/rails_3_0_3_root/config/routes.rb",
    "spec/rails_3_0_3_root/db/seeds.rb",
    "spec/rails_3_0_3_root/features/step_definitions/web_steps.rb",
    "spec/rails_3_0_3_root/features/support/env.rb",
    "spec/rails_3_0_3_root/features/support/paths.rb",
    "spec/rails_3_0_3_root/lib/tasks/.gitkeep",
    "spec/rails_3_0_3_root/lib/tasks/cucumber.rake",
    "spec/rails_3_0_3_root/public/404.html",
    "spec/rails_3_0_3_root/public/422.html",
    "spec/rails_3_0_3_root/public/500.html",
    "spec/rails_3_0_3_root/public/favicon.ico",
    "spec/rails_3_0_3_root/public/images/rails.png",
    "spec/rails_3_0_3_root/public/index.html",
    "spec/rails_3_0_3_root/public/javascripts/application.js",
    "spec/rails_3_0_3_root/public/javascripts/controls.js",
    "spec/rails_3_0_3_root/public/javascripts/dragdrop.js",
    "spec/rails_3_0_3_root/public/javascripts/effects.js",
    "spec/rails_3_0_3_root/public/javascripts/prototype.js",
    "spec/rails_3_0_3_root/public/javascripts/rails.js",
    "spec/rails_3_0_3_root/public/robots.txt",
    "spec/rails_3_0_3_root/public/stylesheets/.gitkeep",
    "spec/rails_3_0_3_root/script/cucumber",
    "spec/rails_3_0_3_root/script/rails",
    "spec/rails_3_0_3_root/spec/spec_helper.rb",
    "spec/rails_3_0_3_root/test/performance/browsing_test.rb",
    "spec/rails_3_0_3_root/test/test_helper.rb",
    "spec/rails_3_0_3_root/vendor/plugins/.gitkeep",
    "spec/spec_helper.rb",
    "spec/support/create_memory_db.rb",
    "spec/support/factories.rb",
    "tasks/rspec.rake"
  ]
  s.homepage = %q{https://github.com/fiftyandfifty/skinnycms}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{skinnycms gem}
  s.test_files = [
    "spec/models/page_content_spec.rb",
    "spec/models/page_spec.rb",
    "spec/rails_3_0_3_root/app/controllers/application_controller.rb",
    "spec/rails_3_0_3_root/app/helpers/application_helper.rb",
    "spec/rails_3_0_3_root/autotest/discover.rb",
    "spec/rails_3_0_3_root/config/application.rb",
    "spec/rails_3_0_3_root/config/boot.rb",
    "spec/rails_3_0_3_root/config/environment.rb",
    "spec/rails_3_0_3_root/config/environments/development.rb",
    "spec/rails_3_0_3_root/config/environments/production.rb",
    "spec/rails_3_0_3_root/config/environments/test.rb",
    "spec/rails_3_0_3_root/config/initializers/backtrace_silencers.rb",
    "spec/rails_3_0_3_root/config/initializers/inflections.rb",
    "spec/rails_3_0_3_root/config/initializers/mime_types.rb",
    "spec/rails_3_0_3_root/config/initializers/secret_token.rb",
    "spec/rails_3_0_3_root/config/initializers/session_store.rb",
    "spec/rails_3_0_3_root/config/routes.rb",
    "spec/rails_3_0_3_root/db/seeds.rb",
    "spec/rails_3_0_3_root/features/step_definitions/web_steps.rb",
    "spec/rails_3_0_3_root/features/support/env.rb",
    "spec/rails_3_0_3_root/features/support/paths.rb",
    "spec/rails_3_0_3_root/spec/spec_helper.rb",
    "spec/rails_3_0_3_root/test/performance/browsing_test.rb",
    "spec/rails_3_0_3_root/test/test_helper.rb",
    "spec/spec_helper.rb",
    "spec/support/create_memory_db.rb",
    "spec/support/factories.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["= 3.0.3"])
      s.add_development_dependency(%q<mongrel>, ["= 1.2.0.pre2"])
      s.add_development_dependency(%q<sqlite3-ruby>, ["= 1.3.2"])
      s.add_development_dependency(%q<factory_girl_rails>, ["= 1.0"])
      s.add_development_dependency(%q<rspec-rails>, ["= 2.2.1"])
      s.add_development_dependency(%q<cucumber>, ["= 0.9.4"])
      s.add_development_dependency(%q<cucumber-rails>, ["= 0.3.2"])
      s.add_development_dependency(%q<shoulda>, ["= 2.11.3"])
      s.add_development_dependency(%q<email_spec>, ["= 1.0.0"])
      s.add_development_dependency(%q<launchy>, ["= 0.3.7"])
      s.add_development_dependency(%q<capybara>, ["= 0.3.9"])
      s.add_development_dependency(%q<capybara-mechanize>, ["= 0.2.3"])
      s.add_development_dependency(%q<autotest-rails>, ["= 4.1.0"])
      s.add_development_dependency(%q<autotest>, ["= 4.4.1"])
      s.add_development_dependency(%q<rcov>, ["= 0.9.9"])
      s.add_development_dependency(%q<bundler>, ["= 1.0.7"])
      s.add_development_dependency(%q<jeweler>, ["= 1.5.1"])
      s.add_runtime_dependency(%q<rails>, ["= 3.0.3"])
      s.add_development_dependency(%q<mongrel>, ["= 1.2.0.pre2"])
      s.add_development_dependency(%q<sqlite3-ruby>, ["= 1.3.2"])
      s.add_development_dependency(%q<factory_girl_rails>, ["= 1.0"])
      s.add_development_dependency(%q<rspec-rails>, ["= 2.2.1"])
      s.add_development_dependency(%q<cucumber>, ["= 0.9.4"])
      s.add_development_dependency(%q<cucumber-rails>, ["= 0.3.2"])
      s.add_development_dependency(%q<shoulda>, ["= 2.11.3"])
      s.add_development_dependency(%q<email_spec>, ["= 1.0.0"])
      s.add_development_dependency(%q<launchy>, ["= 0.3.7"])
      s.add_development_dependency(%q<capybara>, ["= 0.3.9"])
      s.add_development_dependency(%q<capybara-mechanize>, ["= 0.2.3"])
      s.add_development_dependency(%q<autotest-rails>, ["= 4.1.0"])
      s.add_development_dependency(%q<autotest>, ["= 4.4.1"])
      s.add_development_dependency(%q<rcov>, ["= 0.9.9"])
      s.add_development_dependency(%q<bundler>, ["= 1.0.7"])
      s.add_development_dependency(%q<jeweler>, ["= 1.5.1"])
    else
      s.add_dependency(%q<rails>, ["= 3.0.3"])
      s.add_dependency(%q<mongrel>, ["= 1.2.0.pre2"])
      s.add_dependency(%q<sqlite3-ruby>, ["= 1.3.2"])
      s.add_dependency(%q<factory_girl_rails>, ["= 1.0"])
      s.add_dependency(%q<rspec-rails>, ["= 2.2.1"])
      s.add_dependency(%q<cucumber>, ["= 0.9.4"])
      s.add_dependency(%q<cucumber-rails>, ["= 0.3.2"])
      s.add_dependency(%q<shoulda>, ["= 2.11.3"])
      s.add_dependency(%q<email_spec>, ["= 1.0.0"])
      s.add_dependency(%q<launchy>, ["= 0.3.7"])
      s.add_dependency(%q<capybara>, ["= 0.3.9"])
      s.add_dependency(%q<capybara-mechanize>, ["= 0.2.3"])
      s.add_dependency(%q<autotest-rails>, ["= 4.1.0"])
      s.add_dependency(%q<autotest>, ["= 4.4.1"])
      s.add_dependency(%q<rcov>, ["= 0.9.9"])
      s.add_dependency(%q<bundler>, ["= 1.0.7"])
      s.add_dependency(%q<jeweler>, ["= 1.5.1"])
      s.add_dependency(%q<rails>, ["= 3.0.3"])
      s.add_dependency(%q<mongrel>, ["= 1.2.0.pre2"])
      s.add_dependency(%q<sqlite3-ruby>, ["= 1.3.2"])
      s.add_dependency(%q<factory_girl_rails>, ["= 1.0"])
      s.add_dependency(%q<rspec-rails>, ["= 2.2.1"])
      s.add_dependency(%q<cucumber>, ["= 0.9.4"])
      s.add_dependency(%q<cucumber-rails>, ["= 0.3.2"])
      s.add_dependency(%q<shoulda>, ["= 2.11.3"])
      s.add_dependency(%q<email_spec>, ["= 1.0.0"])
      s.add_dependency(%q<launchy>, ["= 0.3.7"])
      s.add_dependency(%q<capybara>, ["= 0.3.9"])
      s.add_dependency(%q<capybara-mechanize>, ["= 0.2.3"])
      s.add_dependency(%q<autotest-rails>, ["= 4.1.0"])
      s.add_dependency(%q<autotest>, ["= 4.4.1"])
      s.add_dependency(%q<rcov>, ["= 0.9.9"])
      s.add_dependency(%q<bundler>, ["= 1.0.7"])
      s.add_dependency(%q<jeweler>, ["= 1.5.1"])
    end
  else
    s.add_dependency(%q<rails>, ["= 3.0.3"])
    s.add_dependency(%q<mongrel>, ["= 1.2.0.pre2"])
    s.add_dependency(%q<sqlite3-ruby>, ["= 1.3.2"])
    s.add_dependency(%q<factory_girl_rails>, ["= 1.0"])
    s.add_dependency(%q<rspec-rails>, ["= 2.2.1"])
    s.add_dependency(%q<cucumber>, ["= 0.9.4"])
    s.add_dependency(%q<cucumber-rails>, ["= 0.3.2"])
    s.add_dependency(%q<shoulda>, ["= 2.11.3"])
    s.add_dependency(%q<email_spec>, ["= 1.0.0"])
    s.add_dependency(%q<launchy>, ["= 0.3.7"])
    s.add_dependency(%q<capybara>, ["= 0.3.9"])
    s.add_dependency(%q<capybara-mechanize>, ["= 0.2.3"])
    s.add_dependency(%q<autotest-rails>, ["= 4.1.0"])
    s.add_dependency(%q<autotest>, ["= 4.4.1"])
    s.add_dependency(%q<rcov>, ["= 0.9.9"])
    s.add_dependency(%q<bundler>, ["= 1.0.7"])
    s.add_dependency(%q<jeweler>, ["= 1.5.1"])
    s.add_dependency(%q<rails>, ["= 3.0.3"])
    s.add_dependency(%q<mongrel>, ["= 1.2.0.pre2"])
    s.add_dependency(%q<sqlite3-ruby>, ["= 1.3.2"])
    s.add_dependency(%q<factory_girl_rails>, ["= 1.0"])
    s.add_dependency(%q<rspec-rails>, ["= 2.2.1"])
    s.add_dependency(%q<cucumber>, ["= 0.9.4"])
    s.add_dependency(%q<cucumber-rails>, ["= 0.3.2"])
    s.add_dependency(%q<shoulda>, ["= 2.11.3"])
    s.add_dependency(%q<email_spec>, ["= 1.0.0"])
    s.add_dependency(%q<launchy>, ["= 0.3.7"])
    s.add_dependency(%q<capybara>, ["= 0.3.9"])
    s.add_dependency(%q<capybara-mechanize>, ["= 0.2.3"])
    s.add_dependency(%q<autotest-rails>, ["= 4.1.0"])
    s.add_dependency(%q<autotest>, ["= 4.4.1"])
    s.add_dependency(%q<rcov>, ["= 0.9.9"])
    s.add_dependency(%q<bundler>, ["= 1.0.7"])
    s.add_dependency(%q<jeweler>, ["= 1.5.1"])
  end
end

