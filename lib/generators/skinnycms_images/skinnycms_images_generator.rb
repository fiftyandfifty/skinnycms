require 'rails/generators'

class SkinnycmsImagesGenerator < Rails::Generators::Base

  desc "Appending SKINNYCMS images to application"

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'images')
  end

  def copy_images
    puts SkinnycmsImagesGenerator.start_description
    sleep(3)
    if Dir["public/images/skinnycms/admin"].blank?
      directory "admin", "public/images/skinnycms/admin"
    else
      if yes? "You already have skinnycms images in 'public/images/skinnycms/admin'directory. Do you want to update it?", :green
        remove_dir "public/images/skinnycms/admin"
        directory "admin", "public/images/skinnycms/admin"
      end
    end
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