require 'rails/generators'

class SkinnycmsLayoutsGenerator < Rails::Generators::Base

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'layouts')
  end

  def copy_layout_files
    copy_file "admin.html.erb", "app/views/layouts/admin.html.erb"
    copy_file "devise.html.erb", "app/views/layouts/devise.html.erb"
  end
end
