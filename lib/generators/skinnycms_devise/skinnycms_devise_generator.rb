require 'rails/generators'

class SkinnycmsDeviseGenerator < Rails::Generators::Base

  desc "Put the devise files to application"

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'devise_files')
  end

  def copy_devise_file
    run "gem install devise -v '1.1.rc2'"
    inject_into_file "Gemfile", :before => "group" do
"gem 'devise', '1.1.rc2'\n\n"
    end
    run "bundle install"
    inject_into_file "config/environments/development.rb", :after => "config.action_mailer.raise_delivery_errors = false\n" do
"  config.action_mailer.default_url_options = { :host => 'localhost:3000' }\n"
    end
    inject_into_file "config/routes.rb", :after => "Application.routes.draw do\n" do
"  devise_for :users\n"
    end
    copy_file "initializers/devise.rb", "config/initializers/devise.rb"
    copy_file "locales/devise.en.yml", "config/locales/devise.en.yml"
  end   
end