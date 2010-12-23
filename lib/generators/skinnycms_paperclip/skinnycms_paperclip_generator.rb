require 'rails/generators'

class SkinnycmsPaperclipGenerator < Rails::Generators::Base

  desc "Put the paperclip to application"

  def copy_devise_file
    run "gem install paperclip -v '2.3.8'"
    inject_into_file "Gemfile", :before => "gem 'skinnycms'" do
"gem 'paperclip', '2.3.8'\n\n"
    end
    run "bundle install"
  end   
end