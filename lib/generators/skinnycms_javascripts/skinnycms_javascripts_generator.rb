require 'rails/generators'

class SkinnycmsJavascriptsGenerator < Rails::Generators::Base

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), '../../../public/javascripts/')
  end

  def copy_javascript_file
    copy_file "some.js", "public/javascripts/skinnycms/admin/some.js"
    puts "Engine's javascript files succesfully copied!"
  end
end
