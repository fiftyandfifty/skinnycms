require 'rails/generators'

class SkinnycmsJavascriptsGenerator < Rails::Generators::Base

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'javasripts')
  end

  def copy_javascript_file
    copy_file "nestedSortable.1.2.1/jquery-1.4.2.min.js", "public/javascripts/skinnycms/nestedSortable.1.2.1/jquery-1.4.2.min.js"
    copy_file "nestedSortable.1.2.1/jquery-ui-1.8.2.custom.min.js", "public/javascripts/skinnycms/nestedSortable.1.2.1/jquery-ui-1.8.2.custom.min.js"
    copy_file "nestedSortable.1.2.1/jquery.ui.nestedSortable.js", "public/javascripts/skinnycms/nestedSortable.1.2.1/jquery.ui.nestedSortable.js"
  end
end
