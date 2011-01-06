require 'rails/generators'

class SkinnycmsGemsGenerator < Rails::Generators::Base

  desc "Installing all required gems to application"

  def install
    puts SkinnycmsGemsGenerator.start_description
    sleep(3)
    run "gem install devise -v '1.1.rc2'"
    run "gem install paperclip -v '2.3.8'"
    run "gem install tumblr-api -v '0.1.4'"
    run "gem install tiny_mce -v '0.1.4'"
    inject_into_file "Gemfile", :before => "gem 'skinnycms'" do
"gem 'devise', '1.1.rc2'\n
gem 'paperclip', '2.3.8'\n
gem 'cloudfiles', '1.4.10'\n
gem 'paperclip-cloudfiles', '2.3.8', :require => 'paperclip'\n
gem 'tumblr-api', '0.1.4', :require => 'tumblr'\n
gem 'tiny_mce', '0.1.4'\n\n"
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
     tumblr-api '0.1.4'
     tinymce '0.1.4'
   successfully installed!

*******************************************************************
        DESCRIPTION
  end
end