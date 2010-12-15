require 'rails/generators'

class SkinnycmsImagesGenerator < Rails::Generators::Base

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'images')
  end

  def copy_stylesheet_file
    copy_file "sortable_icons/minus.jpg", "public/images/skinnycms/sortable_icons/minus.jpg"
    copy_file "sortable_icons/plus.jpg", "public/images/skinnycms/sortable_icons/plus.jpg"
    copy_file "sortable_icons/skrepka.jpg", "public/images/skinnycms/sortable_icons/skrepka.jpg"
  end
end
