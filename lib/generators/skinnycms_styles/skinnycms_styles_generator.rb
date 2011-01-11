require 'rails/generators'

class SkinnycmsStylesGenerator < Rails::Generators::Base

  desc "Appending SKINNYCMS styles to application"

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'stylesheets')
  end

  def copy_stylesheet_files
    puts SkinnycmsStylesGenerator.start_description
    sleep(3)
    copy_file "reset.css", "public/stylesheets/skinnycms/reset.css"
    copy_file "text.css", "public/stylesheets/skinnycms/text.css"
    copy_file "960.css", "public/stylesheets/skinnycms/960.css"
    copy_file "demo.css", "public/stylesheets/skinnycms/demo.css"
    copy_file "all.css", "public/stylesheets/skinnycms/admin/all.css"
    copy_file "ie.css", "public/stylesheets/skinnycms/admin/ie.css"
    copy_file "devise.css", "public/stylesheets/skinnycms/admin/devise.css"
    copy_file "nestedSortable.css", "public/stylesheets/skinnycms/nestedSortable.css"
    puts SkinnycmsStylesGenerator.end_description
  end

  def self.start_description
        <<-DESCRIPTION
*******************************************************************

  SKINNYCMS: Appending styles ...

*******************************************************************
        DESCRIPTION
  end

  def self.end_description
        <<-DESCRIPTION
*******************************************************************

  Styles successfully added!

*******************************************************************
        DESCRIPTION
  end
end
