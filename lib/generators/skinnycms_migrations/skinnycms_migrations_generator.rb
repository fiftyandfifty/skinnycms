require 'rails/generators'
require 'rails/generators/migration'

class SkinnycmsMigrationsGenerator < Rails::Generators::Base

  include Rails::Generators::Migration

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
  
  def create_migration_file
    migration_template 'create_pages.rb', 'db/migrate/create_pages_table.rb'
    rake("db:migrate")
    puts "SkinnyCms Engine succesfully installed!"
  end
end
