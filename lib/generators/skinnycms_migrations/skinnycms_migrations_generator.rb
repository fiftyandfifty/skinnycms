require 'rails/generators'
require 'rails/generators/migration'

class SkinnycmsMigrationsGenerator < Rails::Generators::Base

  include Rails::Generators::Migration

  desc "Creating SKINNYCMS migrations to application"

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end
 
  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.new.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end
  
  def create_migration_files
    puts SkinnycmsMigrationsGenerator.start_description
    sleep(3)
    migration_template 'devise_create_users.rb', 'db/migrate/devise_create_users.rb'
    sleep(1)
    migration_template 'create_pages.rb', 'db/migrate/create_pages.rb'
    sleep(1)
    migration_template 'create_page_contents.rb', 'db/migrate/create_page_contents.rb'
    sleep(1)
    migration_template 'create_api_modules.rb', 'db/migrate/create_api_modules.rb'
    sleep(1)
    migration_template 'create_custom_modules.rb', 'db/migrate/create_custom_modules.rb'
    sleep(1)
    migration_template 'create_categories.rb', 'db/migrate/create_categories.rb'
    sleep(1)
    migration_template 'create_category_items.rb', 'db/migrate/create_category_items.rb'
    sleep(1)
    migration_template 'create_cache_tumblr_posts.rb', 'db/migrate/create_cache_tumblr_posts.rb'
    sleep(1)
    migration_template 'create_cache_fleakr_galleries.rb', 'db/migrate/create_cache_fleakr_galleries.rb'
    sleep(1)
    migration_template 'create_cache_vimeo_videos.rb', 'db/migrate/create_cache_vimeo_videos.rb'
    sleep(1)
    migration_template 'create_images.rb', 'db/migrate/create_images.rb'
    sleep(1)
    rake("db:migrate")
    puts SkinnycmsMigrationsGenerator.end_description
  end

  def self.start_description
        <<-DESCRIPTION
*******************************************************************

  SKINNYCMS: Create migrations ...

*******************************************************************
        DESCRIPTION
  end

  def self.end_description
        <<-DESCRIPTION
*******************************************************************

  Migrations successfully created!

*******************************************************************
        DESCRIPTION
  end
end
