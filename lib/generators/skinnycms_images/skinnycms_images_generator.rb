require 'rails/generators'

class SkinnycmsImagesGenerator < Rails::Generators::Base

  desc "Appending SKINNYCMS images to application"

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'images')
  end

  def copy_images
    puts SkinnycmsImagesGenerator.start_description
    sleep(3)
    directory "admin", "public/images/skinnycms/admin"
    directory "sortable_icons", "public/images/skinnycms/sortable_icons"
    puts SkinnycmsImagesGenerator.end_description
  end

  def self.start_description
        <<-DESCRIPTION
*******************************************************************

  SKINNYCMS: Appending images ...

*******************************************************************
        DESCRIPTION
  end

  def self.end_description
        <<-DESCRIPTION
*******************************************************************

  Images successfully added!

*******************************************************************
        DESCRIPTION
  end
end