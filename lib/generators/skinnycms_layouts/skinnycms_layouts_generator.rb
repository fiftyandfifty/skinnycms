require 'rails/generators'

class SkinnycmsLayoutsGenerator < Rails::Generators::Base

  desc "Appending SKINNYCMS layouts to application"

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'layouts')
  end

  def copy_layout_files
    puts SkinnycmsLayoutsGenerator.start_description
    sleep(3)
    copy_file "front_end.html.erb", "app/views/layouts/front_end.html.erb"
    copy_file "admin.html.erb", "app/views/layouts/admin.html.erb"
    copy_file "devise.html.erb", "app/views/layouts/devise.html.erb"
    puts SkinnycmsLayoutsGenerator.end_description
  end

  def self.start_description
        <<-DESCRIPTION
*******************************************************************

  SKINNYCMS: Appending layouts ...

*******************************************************************
        DESCRIPTION
  end

  def self.end_description
        <<-DESCRIPTION
*******************************************************************

  Layouts successfully added!

*******************************************************************
        DESCRIPTION
  end
end
