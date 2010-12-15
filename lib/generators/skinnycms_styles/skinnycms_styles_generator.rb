require 'rails/generators'

class SkinnycmsStylesGenerator < Rails::Generators::Base

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'stylesheets')
  end

  def copy_stylesheet_file
    copy_file "admin.css", "public/stylesheets/skinnycms/admin.css"
    copy_file "base.css", "public/stylesheets/skinnycms/base.css"
    copy_file "defaults.css", "public/stylesheets/skinnycms/defaults.css"
    copy_file "nestedSortable.css", "public/stylesheets/skinnycms/nestedSortable.css"
  end
end
