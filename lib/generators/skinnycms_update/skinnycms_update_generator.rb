require 'rails/generators'

class SkinnycmsUpdateGenerator < Rails::Generators::Base

  desc "Creating SKINNYCMS migrations to application"
  
  def create_migration_files
    Dir.chdir("#{RAILS_ROOT}/db/")
    if File.exist?("schema.rb")
      db_schema = IO.read('schema.rb')
      table_name = "users".upcase
      table_string = "create_table \"users\","
      if db_schema.scan(table_string).size > 0
        if yes? "Hey guy! You already have #{table_name}! Push 'yes' to update table or 'no' to create new 'skinny_users' table?"
          say "Updating table…", :green
        else
          say "Creating 'skinny_users' table…", :red
        end
      end
    else
      say "Creating 'users' table…", :green
    end
  end

end
