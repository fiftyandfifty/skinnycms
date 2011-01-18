require 'rails/generators'

class SkinnycmsGemsGenerator < Rails::Generators::Base

  desc "Installing all required gems to application"

  def install
    puts SkinnycmsGemsGenerator.start_description
    sleep(3)
    run "gem install devise -v '1.1.rc2'"
    run "gem install paperclip -v '2.3.8'"
    run "gem install cloudfiles -v '1.4.10'"
    run "gem install paperclip-cloudfiles -v '2.3.8'"
    run "gem install tumblr-api -v '0.1.4'"
    run "cd #{RAILS_ROOT}/vendor && mkdir forks"
    run "cd #{RAILS_ROOT}"
    run "cd #{RAILS_ROOT}/vendor/forks/ && git clone git@github.com:RuslanHamidullin/fleakr.git"
    run "cd #{RAILS_ROOT}/vendor/forks/fleakr && rake install"
    run "cd #{RAILS_ROOT}"
    run "gem install vimeo -v '1.3.0'"
    run "gem install tiny_mce -v '0.1.4'"
    run "gem install acts_as_list -v '0.1.2'"
    run "gem install acts_as_tree -v '0.1.1'"
    run "gem install will_paginate -v '2.3.15'"
    inject_into_file "Gemfile", :before => "gem 'skinnycms'" do
"gem 'devise', '1.1.rc2'\n
gem 'paperclip', '2.3.8'\n
gem 'cloudfiles', '1.4.10'\n
gem 'paperclip-cloudfiles', '2.3.8', :require => 'paperclip'\n
gem 'tumblr-api', '0.1.4', :require => 'tumblr'\n
gem 'fleakr', :path => 'vendor/forks/fleakr'\n
gem 'vimeo', '1.3.0'\n
gem 'tiny_mce', '0.1.4'\n
gem 'acts_as_list', '0.1.2'\n
gem 'acts_as_tree', '0.1.1'\n
gem 'will_paginate', '2.3.15'\n\n"
    end
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
     devise '1.1.rc2'
     paperclip '2.3.8'
     cloudfiles, '1.4.10'
     paperclip-cloudfiles, '2.3.8'
     tumblr-api '0.1.4'
     fleakr '0.6.4'
     vimeo '1.3.0'
     tinymce '0.1.4'
     acts_as_list, '0.1.2'
     acts_as_tree, '0.1.1'
     will_paginate, '2.3.15'
   successfully installed!

*******************************************************************
        DESCRIPTION
  end
end