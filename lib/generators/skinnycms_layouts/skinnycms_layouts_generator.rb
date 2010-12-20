require 'rails/generators'

class SkinnycmsLayoutsGenerator < Rails::Generators::Base

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'layouts')
  end

  def copy_layout_files
    copy_file "front_end.html.erb", "app/views/layouts/front_end.html.erb"
  end
end
