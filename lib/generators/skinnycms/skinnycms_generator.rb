require 'rails/generators'

class SkinnycmsGenerator < Rails::Generators::Base

  desc "Fully installing SKINNYCMS to application"

  def install
    run "rails generate skinnycms_gems"
    run "rails generate skinnycms_devise"
    run "rails generate skinnycms_tinymce"
    run "rails generate skinnycms_migrations"
    run "rails generate skinnycms_layouts"
    run "rails generate skinnycms_styles"
    run "rails generate skinnycms_javascripts"
    run "rails generate skinnycms_images"
    puts SkinnycmsGenerator.end_description
  end

  def self.end_description
        <<-DESCRIPTION
*******************************************************************

  SKINNYCMS successfully installed!

*******************************************************************
        DESCRIPTION
  end
end