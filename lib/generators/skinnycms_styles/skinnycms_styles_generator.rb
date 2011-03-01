require 'rails/generators'

class SkinnycmsStylesGenerator < Rails::Generators::Base

  desc "Appending SKINNYCMS styles to application"

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'stylesheets')
  end

  def copy_stylesheet_files
    puts SkinnycmsStylesGenerator.start_description
    sleep(3)

    if !File.exist?("public/stylesheets/skinnycms/reset.css")
      copy_file "reset.css", "public/stylesheets/skinnycms/reset.css"
    else
      if yes? "You already have 'public/stylesheets/skinnycms/reset.css' file. Do you want to update it?", :green
        remove_file "public/stylesheets/skinnycms/reset.css"
        copy_file "reset.css", "public/stylesheets/skinnycms/reset.css"
      end
    end

    if !File.exist?("public/stylesheets/skinnycms/text.css")
      copy_file "text.css", "public/stylesheets/skinnycms/text.css"
    else
      if yes? "You already have 'public/stylesheets/skinnycms/text.css' file. Do you want to update it?", :green
        remove_file "public/stylesheets/skinnycms/text.css"
        copy_file "text.css", "public/stylesheets/skinnycms/text.css"
      end
    end

    if !File.exist?("public/stylesheets/skinnycms/960.css")
      copy_file "960.css", "public/stylesheets/skinnycms/960.css"
    else
      if yes? "You already have 'public/stylesheets/skinnycms/960.css' file. Do you want to update it?", :green
        remove_file "public/stylesheets/skinnycms/960.css"
        copy_file "960.css", "public/stylesheets/skinnycms/960.css"
      end
    end

    if !File.exist?("public/stylesheets/skinnycms/demo.css")
      copy_file "demo.css", "public/stylesheets/skinnycms/demo.css"
    else
      if yes? "You already have 'public/stylesheets/skinnycms/demo.css' file. Do you want to update it?", :green
        remove_file "public/stylesheets/skinnycms/demo.css"
        copy_file "demo.css", "public/stylesheets/skinnycms/demo.css"
      end
    end

    if !File.exist?("public/stylesheets/skinnycms/admin/all.css")
      copy_file "all.css", "public/stylesheets/skinnycms/admin/all.css"
    else
      if yes? "You already have 'public/stylesheets/skinnycms/admin/all.css' file. Do you want to update it?", :green
        remove_file "public/stylesheets/skinnycms/admin/all.css"
        copy_file "all.css", "public/stylesheets/skinnycms/admin/all.css"
      end
    end

    if !File.exist?("public/stylesheets/skinnycms/admin/ie.css")
      copy_file "ie.css", "public/stylesheets/skinnycms/admin/ie.css"
    else
      if yes? "You already have 'public/stylesheets/skinnycms/admin/ie.css' file. Do you want to update it?", :green
        remove_file "public/stylesheets/skinnycms/admin/ie.css"
        copy_file "ie.css", "public/stylesheets/skinnycms/admin/ie.css"
      end
    end

    if !File.exist?("public/stylesheets/skinnycms/admin/devise.css")
      copy_file "devise.css", "public/stylesheets/skinnycms/admin/devise.css"
    else
      if yes? "You already have 'public/stylesheets/skinnycms/admin/devise.css' file. Do you want to update it?", :green
        remove_file "public/stylesheets/skinnycms/admin/devise.css"
        copy_file "devise.css", "public/stylesheets/skinnycms/admin/devise.css"
      end
    end

    if !File.exist?("public/stylesheets/skinnycms/nestedSortable.css")
      copy_file "nestedSortable.css", "public/stylesheets/skinnycms/nestedSortable.css"
    else
      if yes? "You already have 'public/stylesheets/skinnycms/nestedSortable.css' file. Do you want to update it?", :green
        remove_file "public/stylesheets/skinnycms/nestedSortable.css"
        copy_file "nestedSortable.css", "public/stylesheets/skinnycms/nestedSortable.css"
      end
    end

     if !File.exist?("public/stylesheets/skinnycms/jquery-ui-1.8.10.custom.css")
      copy_file "jquery-ui-1.8.10.custom.css", "public/stylesheets/skinnycms/jquery-ui-1.8.10.custom.css"
    else
      if yes? "You already have 'public/stylesheets/skinnycms/jquery-ui-1.8.10.custom.css' file. Do you want to update it?", :green
        remove_file "public/stylesheets/skinnycms/jquery-ui-1.8.10.custom.css"
        copy_file "jquery-ui-1.8.10.custom.css", "public/stylesheets/skinnycms/jquery-ui-1.8.10.custom.css"
      end
    end
    
     if !File.exist?("public/stylesheets/skinnycms/validationEngine.jquery.css")
      copy_file "validationEngine.jquery.css", "public/stylesheets/skinnycms/validationEngine.jquery.css"
    else
      if yes? "You already have 'public/stylesheets/skinnycms/validationEngine.jquery.css' file. Do you want to update it?", :green
        remove_file "public/stylesheets/skinnycms/validationEngine.jquery.css"
        copy_file "validationEngine.jquery.css", "public/stylesheets/skinnycms/validationEngine.jquery.css"
      end
    end

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
