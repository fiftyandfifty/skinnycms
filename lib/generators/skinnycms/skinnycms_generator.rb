require 'rails/generators'

class SkinnycmsGenerator < Rails::Generators::Base

  def install
    run "rails generate skinnycms_devise"
    run "rails generate skinnycms_tumblr"
    run "rails generate skinnycms_paperclip"
    run "rails generate skinnycms_migrations"
    run "rails generate skinnycms_javascripts"
    run "rails generate skinnycms_styles"
    run "rails generate skinnycms_images"
    run "rails generate skinnycms_layouts"
    puts "SKINNYCMS succesfully installed!"
  end
end