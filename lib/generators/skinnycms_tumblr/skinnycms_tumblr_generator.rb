require 'rails/generators'

class SkinnycmsTumblrGenerator < Rails::Generators::Base

  desc "Put the tumblr-api to application"

  def copy_devise_file
    run "gem install tumblr-api -v '0.1.4'"
    inject_into_file "Gemfile", :before => "gem 'skinnycms'" do
"gem 'tumblr-api', '0.1.4', :require => 'tumblr'\n\n"
    end
    run "bundle install"
  end   
end