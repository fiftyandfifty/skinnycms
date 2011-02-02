require 'rails/generators'

class SkinnycmsJavascriptsGenerator < Rails::Generators::Base

  desc "Appending SKINNYCMS javascripts to application"

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'javasripts')
  end

  def copy_javascript_files
    puts SkinnycmsJavascriptsGenerator.start_description
    sleep(3)

    if !File.exist?("public/javascripts/skinnycms/admin/main.js")
      copy_file "main.js", "public/javascripts/skinnycms/admin/main.js"
    end

    if !File.exist?("public/javascripts/skinnycms/rails.js")
      copy_file "rails.js", "public/javascripts/skinnycms/rails.js"
    end

    if !File.exist?("public/javascripts/skinnycms/nestedSortable.1.2.1/jquery-1.4.2.min.js")
      copy_file "nestedSortable.1.2.1/jquery-1.4.2.min.js", "public/javascripts/skinnycms/nestedSortable.1.2.1/jquery-1.4.2.min.js"
    end

    if !File.exist?("public/javascripts/skinnycms/nestedSortable.1.2.1/jquery-ui-1.8.2.custom.min.js")
      copy_file "nestedSortable.1.2.1/jquery-ui-1.8.2.custom.min.js", "public/javascripts/skinnycms/nestedSortable.1.2.1/jquery-ui-1.8.2.custom.min.js"
    end

    if !File.exist?("public/javascripts/skinnycms/nestedSortable.1.2.1/jquery.ui.nestedSortable.js")
      copy_file "nestedSortable.1.2.1/jquery.ui.nestedSortable.js", "public/javascripts/skinnycms/nestedSortable.1.2.1/jquery.ui.nestedSortable.js"
    end

    if !File.exist?("public/javascripts/skinnycms/jquery/jquery-1.4.4.min.js")
      copy_file "jquery/jquery-1.4.4.min.js", "public/javascripts/skinnycms/jquery/jquery-1.4.4.min.js"
    end

    if !File.exist?("public/javascripts/skinnycms/jquery/jquery-ui-1.8.7.custom.min.js")
      copy_file "jquery/jquery-ui-1.8.7.custom.min.js", "public/javascripts/skinnycms/jquery/jquery-ui-1.8.7.custom.min.js"
    end

    if !File.exist?("public/javascripts/skinnycms/jquery/jquery.livequery.js")
      copy_file "jquery/jquery.livequery.js", "public/javascripts/skinnycms/jquery/jquery.livequery.js"
    end
    
    puts SkinnycmsJavascriptsGenerator.end_description
  end

  def self.start_description
        <<-DESCRIPTION
*******************************************************************

  SKINNYCMS: Appending javascripts ...

*******************************************************************
        DESCRIPTION
  end

  def self.end_description
        <<-DESCRIPTION
*******************************************************************

  Javascripts successfully added!

*******************************************************************
        DESCRIPTION
  end
end
