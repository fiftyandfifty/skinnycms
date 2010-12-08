require 'rails/generators'

class SkinnycmsStylesGenerator < Rails::Generators::Base

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), '../../../public/stylesheets/')
  end

  def copy_stylesheet_file
    copy_file "scaffold.css", "public/stylesheets/skinnycms/admin/pages.css"
    puts "Engine's CSS styles succesfully copied!"
  end
end
