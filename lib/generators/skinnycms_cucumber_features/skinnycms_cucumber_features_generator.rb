require 'rails/generators'

class SkinnycmsCucumberFeaturesGenerator < Rails::Generators::Base

  desc "Put the cucumber features in place"


  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'features_templates')
  end

  def install
    directory "features"

    inject_into_file "features/support/paths.rb", :after => "# Add more mappings here.\n" do
"    # Skinnycms routes.
    when /the user login page/
      '/users/sign_in'
    when /the admin_pages page/
      '/admin/pages'
    when /the admin_users page/
      '/admin/users'
    when /the admin_categories page/
      '/admin/categories'\n"
    end
  end
end