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
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "app/controllers/admin/pages_controller.rb",
    "app/models/page.rb",
    "app/views/admin/pages/_page_list.html.erb",
    "app/views/admin/pages/edit.html.erb",
    "app/views/admin/pages/index.html.erb",
    "app/views/admin/pages/new.html.erb",
    "app/views/admin/pages/show.html.erb",
    "config/routes.rb",
    "lib/generators/skinnycms_images/USAGE",
    "lib/generators/skinnycms_images/skinnycms_images_generator.rb",
    "lib/generators/skinnycms_javascripts/USAGE",
    "lib/generators/skinnycms_javascripts/skinnycms_javascripts_generator.rb",
    "lib/generators/skinnycms_migrations/USAGE",
    "lib/generators/skinnycms_migrations/skinnycms_migrations_generator.rb",
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
    "skinnycms.gemspec"
  ]
  s.homepage = %q{https://github.com/fiftyandfifty/skinnycms}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{skinnycms gem}
  s.test_files = [
    "spec/skinnycms_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.1.0"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.1.0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.1.0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

