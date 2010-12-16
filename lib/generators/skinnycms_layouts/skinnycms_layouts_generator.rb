require 'rails/generators'

class SkinnycmsLayoutsGenerator < Rails::Generators::Base

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'layouts')
  end

  def copy_layout_files
    copy_file "application.html.erb", "app/views/layouts/application.html.erb"
  end
end
