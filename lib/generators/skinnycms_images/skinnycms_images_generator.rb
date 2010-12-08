require 'rails/generators'

class SkinnycmsImagesGenerator < Rails::Generators::Base

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), '../../../public/images/')
  end

  def copy_stylesheet_file
    copy_file "some.gif", "public/images/skinnycms/admin/some.gif"
    puts "Engine's images succesfully copied!"
  end
end
