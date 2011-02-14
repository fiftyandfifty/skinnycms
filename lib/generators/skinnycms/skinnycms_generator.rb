require 'rails/generators'

class SkinnycmsGenerator < Rails::Generators::Base

  desc "Fully installing SKINNYCMS to application"

  def install
    run "rails generate skinnycms_gems"
    run "rails generate skinnycms_devise"
    run "rails generate skinnycms_tinymce"
    run "rails generate skinnycms_cloudfiles"
    run "rails generate friendly_id"
    run "rails generate skinnycms_migrations"
    run "rails generate skinnycms_layouts"
    run "rails generate skinnycms_styles"
    run "rails generate skinnycms_javascripts"
    run "rails generate skinnycms_images"
    remove_file 'public/index.html' if File.exist?('public/index.html')
    puts SkinnycmsGenerator.end_description
  end

  def self.end_description
        <<-DESCRIPTION
*******************************************************************

  SKINNYCMS successfully installed!

  Now, you can run 'rails generate skinnycms_homepage'
  to generate default homepage for your application!

  Also, you can run 'rails generate skinnycms_db_seeds',
  it will add to your database all necessary content
  for best testing your application!

  Enjoy your SKINNYCMS!

*******************************************************************
        DESCRIPTION
  end
end