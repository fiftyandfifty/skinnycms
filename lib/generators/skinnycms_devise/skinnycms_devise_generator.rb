require 'rails/generators'

class SkinnycmsDeviseGenerator < Rails::Generators::Base

  desc "Integrate devise to application"

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'devise_files')
  end

  def copy_devise_files
    puts SkinnycmsDeviseGenerator.start_description
    sleep(3)

    config_env_file = IO.read('config/environments/development.rb')
    config_routes_file = IO.read('config/routes.rb')
    config_app_file = IO.read('app/controllers/application_controller.rb')

    if config_env_file.scan("  config.action_mailer.default_url_options = { :host => 'localhost:3000' }").size < 1
      insert_into_file "config/environments/development.rb",
                       "  config.action_mailer.default_url_options = { :host => 'localhost:3000' }\n",
                       :after => "config.action_mailer.raise_delivery_errors = false\n"
    end

    if config_routes_file.scan("devise_for :users").size < 1
      insert_into_file "config/routes.rb",
                       "  devise_for :users\n",
                       :after => "Application.routes.draw do\n"
    end

    if config_app_file.scan("def layout_by_resource").size < 1
    insert_into_file "app/controllers/application_controller.rb",
"  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      'devise'
    else
      'application'
    end
  end\n\n", :after => "class ApplicationController < ActionController::Base\n"
    end

    if !File.exist?('config/initializers/devise.rb')
      copy_file "initializers/devise.rb", "config/initializers/devise.rb"
    else
      if yes? "You already have 'config/initializers/devise.rb' file. Do you want to update it?", :green
        remove_file "config/initializers/devise.rb"
        copy_file "initializers/devise.rb", "config/initializers/devise.rb"
      end
    end

    if !File.exist?('config/locales/devise.en.yml')
      copy_file "locales/devise.en.yml", "config/locales/devise.en.yml"
    else
      if yes? "You already have 'config/locales/devise.en.yml' file. Do you want to update it?", :green
        remove_file "config/locales/devise.en.yml"
        copy_file "locales/devise.en.yml", "config/locales/devise.en.yml"
      end
    end

    puts SkinnycmsDeviseGenerator.end_description
  end

  def self.start_description
        <<-DESCRIPTION
*******************************************************************

  SKINNYCMS: Configuring devise ...

*******************************************************************
        DESCRIPTION
  end

  def self.end_description
        <<-DESCRIPTION
*******************************************************************

  Devise successfully configured!

*******************************************************************
        DESCRIPTION
  end
end