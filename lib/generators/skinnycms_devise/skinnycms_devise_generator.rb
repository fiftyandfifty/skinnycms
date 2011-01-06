require 'rails/generators'

class SkinnycmsDeviseGenerator < Rails::Generators::Base

  desc "Integrate devise to application"

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'devise_files')
  end

  def copy_devise_files
    puts SkinnycmsDeviseGenerator.start_description
    sleep(3)
    inject_into_file "config/environments/development.rb", :after => "config.action_mailer.raise_delivery_errors = false\n" do
"  config.action_mailer.default_url_options = { :host => 'localhost:3000' }\n"
    end
    inject_into_file "config/routes.rb", :after => "Application.routes.draw do\n" do
"  devise_for :users\n"
    end
    copy_file "initializers/devise.rb", "config/initializers/devise.rb"
    copy_file "locales/devise.en.yml", "config/locales/devise.en.yml"
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