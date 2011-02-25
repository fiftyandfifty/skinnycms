require 'rails/generators'

class SkinnycmsGemsGenerator < Rails::Generators::Base

  desc "Installing all required gems to application"

  def install
    puts SkinnycmsGemsGenerator.start_description
    sleep(3)

    Dir.chdir("#{RAILS_ROOT}/")
    gemfile = IO.read('Gemfile')

    run "gem install devise -v '1.2.rc'" if gemfile.scan("devise").size < 1
    run "gem install paperclip -v '2.3.8'" if gemfile.scan("paperclip").size < 1
    run "gem install cloudfiles -v '1.4.10'" if gemfile.scan("cloudfiles").size < 1
    run "gem install paperclip-cloudfiles -v '2.3.8'" if gemfile.scan("paperclip-cloudfiles").size < 1

     if gemfile.scan("fleakr").size < 1
    run "cd #{RAILS_ROOT}/vendor && mkdir forks"
    run "cd #{RAILS_ROOT}"
    run "cd #{RAILS_ROOT}/vendor/forks/ && git clone git@github.com:RuslanHamidullin/fleakr.git"
    run "cd #{RAILS_ROOT}/vendor/forks/fleakr && rake install"
    run "cd #{RAILS_ROOT}"
     end

    run "gem install vimeo -v '1.3.0'" if gemfile.scan("vimeo").size < 1
    run "gem install tiny_mce -v '0.1.4'" if gemfile.scan("tiny_mce").size < 1
    run "gem install acts_as_list -v '0.1.2'" if gemfile.scan("acts_as_list").size < 1
    run "gem install acts_as_tree -v '0.1.1'" if gemfile.scan("acts_as_tree").size < 1
    run "gem install will_paginate -v '2.3.15'" if gemfile.scan("will_paginate").size < 1
    run "gem install friendly_id -v '3.0.6'" if gemfile.scan("friendly_id").size < 1

    insert_into_file "Gemfile", "gem 'devise', '1.2.rc'\n\n", :before => "gem 'skinnycms'" if gemfile.scan("devise").size < 1
    insert_into_file "Gemfile", "gem 'paperclip', '2.3.8'\n\n", :before => "gem 'skinnycms'" if gemfile.scan("paperclip").size < 1
    insert_into_file "Gemfile", "gem 'cloudfiles', '1.4.10'\n\n", :before => "gem 'skinnycms'" if gemfile.scan("cloudfiles").size < 1
    insert_into_file "Gemfile", "gem 'paperclip-cloudfiles', '2.3.8', :require => 'paperclip'\n\n", :before => "gem 'skinnycms'" if gemfile.scan("paperclip-cloudfiles").size < 1
    insert_into_file "Gemfile", "gem 'fleakr', :path => 'vendor/forks/fleakr'\n\n", :before => "gem 'skinnycms'" if gemfile.scan("fleakr").size < 1
    insert_into_file "Gemfile", "gem 'vimeo', '1.3.0'\n\n", :before => "gem 'skinnycms'" if gemfile.scan("vimeo").size < 1
    insert_into_file "Gemfile", "gem 'tiny_mce', '0.1.4'\n\n", :before => "gem 'skinnycms'" if gemfile.scan("tiny_mce").size < 1
    insert_into_file "Gemfile", "gem 'acts_as_list', '0.1.2'\n\n", :before => "gem 'skinnycms'" if gemfile.scan("acts_as_list").size < 1
    insert_into_file "Gemfile", "gem 'acts_as_tree', '0.1.1'\n\n", :before => "gem 'skinnycms'" if gemfile.scan("acts_as_tree").size < 1
    insert_into_file "Gemfile", "gem 'will_paginate', '2.3.15'\n\n", :before => "gem 'skinnycms'" if gemfile.scan("will_paginate").size < 1
    insert_into_file "Gemfile", "gem 'friendly_id', '3.0.6'\n\n", :before => "gem 'skinnycms'" if gemfile.scan("friendly_id").size < 1

    run "bundle install"
    puts SkinnycmsGemsGenerator.end_description
  end

  def self.start_description
        <<-DESCRIPTION
*******************************************************************

  SKINNYCMS: Installing all required gems ...

*******************************************************************
        DESCRIPTION
  end

  def self.end_description
        <<-DESCRIPTION
*******************************************************************

   Gems:
     devise '1.2.rc'
     paperclip '2.3.8'
     cloudfiles, '1.4.10'
     paperclip-cloudfiles, '2.3.8'
     fleakr '0.6.4'
     vimeo '1.3.0'
     tinymce '0.1.4'
     acts_as_list, '0.1.2'
     acts_as_tree, '0.1.1'
     will_paginate, '2.3.15'
     friendly_id, '3.0.6'
   successfully installed!

*******************************************************************
        DESCRIPTION
  end
end