require 'rails/generators'

class SkinnycmsLayoutsGenerator < Rails::Generators::Base

  desc "Appending SKINNYCMS layouts to application"

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'layouts')
  end

  def copy_layout_files
    puts SkinnycmsLayoutsGenerator.start_description
    sleep(3)

    if !File.exist?('app/views/layouts/admin.html.erb')
      copy_file "admin.html.erb", "app/views/layouts/admin.html.erb"
    else
      if yes? "You already have 'app/views/layouts/admin.html.erb' layout. Do you want to update it?", :green
        remove_file "app/views/layouts/admin.html.erb"
        copy_file "admin.html.erb", "app/views/layouts/admin.html.erb"
      end
    end

    if !File.exist?('app/views/layouts/devise.html.erb')
      copy_file "devise.html.erb", "app/views/layouts/devise.html.erb"
    else
      if yes? "You already have 'app/views/layouts/devise.html.erb' layout. Do you want to update it?", :green
        remove_file "app/views/layouts/devise.html.erb"
        copy_file "devise.html.erb", "app/views/layouts/devise.html.erb"
      end
    end

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
