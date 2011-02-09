require 'rails/generators'
require 'rails/generators/migration'

class SkinnycmsMigrationsGenerator < Rails::Generators::Base

  include Rails::Generators::Migration

  desc "Creating SKINNYCMS migrations to application"

  def create_migrations
    puts self.class.start_description
    sleep(3)

    Dir.mkdir("db/migrate") if Dir["db/migrate"].blank?
    Dir.chdir("#{RAILS_ROOT}/db/migrate")

    user_columns = {
                    :email => "string",
                    :encrypted_password => "string",
                    :password_salt => "string",
                    :confirmation_token => "string",
                    :reset_password_token => "string",
                    :remember_token => "string",
                    :current_sign_in_ip => "string",
                    :last_sign_in_ip => "string",
                    :sign_in_count => "integer",
                    :remember_created_at => "datetime",
                    :current_sign_in_at => "datetime",
                    :last_sign_in_at => "datetime",
                    :confirmed_at => "datetime",
                    :confirmation_sent_at => "datetime"
                    }

    user_indexes = [
                    "index_users_on_reset_password_token",
                    "index_users_on_confirmation_token",
                    "index_users_on_email"
                   ]

    page_columns = {
                    :title => "string",
                    :permalink => "string",
                    :status => "string",
                    :redirect_url => "string",
                    :seo_title => "string",
                    :seo_description => "text",
                    :seo_keywords => "string",
                    :template_id => "integer"
                    }

    page_indexes = []

    page_content_columns = {
                    :page_id => "integer",
                    :content => "text",
                    :position => "integer",
                    :location => "string",
                    :module_type => "string",
                    :module_id => "integer"
                    }

    page_content_indexes = []

    api_module_columns = {
                    :title => "string",
                    :module_name => "string",
                    :module_version => "string",
                    :configuration => "text"
                    }

    api_module_indexes = []

    custom_module_columns = {
                    :title => "string",
                    :header => "text",
                    :content => "text",
                    :sidebar => "text"
                    }

    custom_module_indexes = []

    cache_fleakr_gallery_columns = {
                    :fleakr_gallery_id => "string",
                    :title => "string",
                    :description => "text",
                    :incomplete => "boolean"
                    }

    cache_fleakr_gallery_indexes = [
                    "index_fleakr_galleries_on_complete_id"
                    ]

    cache_vimeo_video_columns = {
                    :vimeo_video_id => "string",
                    :title => "string",
                    :description => "text",
                    :url => "string",
                    :upload_date => "datetime",
                    :incomplete => "boolean"
                    }

    cache_vimeo_video_indexes = [
                    "index_vimeo_videos_on_complete_id"
                    ]

    cache_tumblr_post_columns = {
                    :tumblr_post_id => "string",
                    :title => "string",
                    :desc => "text",
                    :url => "string",
                    :reblog_key => "string",
                    :post_type => "string",
                    :post_date => "datetime",
                    :incomplete => "boolean"
                    }

    cache_tumblr_post_indexes = [
                    "index_tumblr_posts_on_complete_id"
                    ]

    asset_columns = {
                    :title => "string",
                    :description => "text",
                    :asset_file_name => "string",
                    :asset_content_type => "string",
                    :asset_file_size => "integer",
                    :asset_updated_at => "datetime",
                    }

    asset_indexes = []

    navigations_columns = {
                    :title => "string"
                    }

    navigations_indexes = []

    pages_to_navigations_columns = {
                    :nav_id => "integer",
                    :page_id => "integer",
                    :parent_id => "integer",
                    :position => "integer",
                    :visibility => "string"
                    }

    pages_to_navigations_indexes = []

    templates_columns = {
                    :title => "string"
                    }

    templates_indexes = []

    begin
      user_app_columns = ActiveRecord::Base::User.column_names
      user_app_indexes = ActiveRecord::Base.connection.indexes("users")
      self.class.define_migration("users", user_columns, user_app_columns, user_indexes, user_app_indexes)
    rescue
      self.class.check_migration_file("*create_users*", "create_users.rb")
    end
    sleep(1)

    begin
      page_app_columns = ActiveRecord::Base::Page.column_names
      page_app_indexes = ActiveRecord::Base.connection.indexes("pages")
      self.class.define_migration("pages", page_columns, page_app_columns, page_indexes, page_app_indexes)
    rescue
      self.class.check_migration_file("*create_pages*", "create_pages.rb")
    end
    sleep(1)

    begin
      page_content_app_columns = ActiveRecord::Base::PageContent.column_names
      page_content_app_indexes = ActiveRecord::Base.connection.indexes("page_contents")
      self.class.define_migration("page_contents", page_content_columns, page_content_app_columns, page_content_indexes, page_content_app_indexes)
    rescue
      self.class.check_migration_file("*create_page_contents*", "create_page_contents.rb")
    end
    sleep(1)

    begin
      api_module_app_columns = ActiveRecord::Base::ApiModule.column_names
      api_module_app_indexes = ActiveRecord::Base.connection.indexes("api_modules")
      self.class.define_migration("api_modules", api_module_columns, api_module_app_columns, api_module_indexes, api_module_app_indexes)
    rescue
      self.class.check_migration_file("*create_api_modules*", "create_api_modules.rb")
    end
    sleep(1)

    begin
      custom_module_app_columns = ActiveRecord::Base::CustomModule.column_names
      custom_module_app_indexes = ActiveRecord::Base.connection.indexes("custom_modules")
      self.class.define_migration("custom_modules", custom_module_columns, custom_module_app_columns, custom_module_indexes, custom_module_app_indexes)
    rescue
      self.class.check_migration_file("*create_custom_modules*", "create_custom_modules.rb")
    end
    sleep(1)

    begin
      cache_fleakr_gallery_app_columns = ActiveRecord::Base::CacheFleakrGallery.column_names
      cache_fleakr_gallery_app_indexes = ActiveRecord::Base.connection.indexes("cache_fleakr_galleries")
      self.class.define_migration("cache_fleakr_galleries", cache_fleakr_gallery_columns, cache_fleakr_gallery_app_columns, cache_fleakr_gallery_indexes, cache_fleakr_gallery_app_indexes)
    rescue
      self.class.check_migration_file("*create_cache_fleakr_galleries*", "create_cache_fleakr_galleries.rb")
    end
    sleep(1)

    begin
      cache_vimeo_video_app_columns = ActiveRecord::Base::CacheVimeoVideo.column_names
      cache_vimeo_video_app_indexes = ActiveRecord::Base.connection.indexes("cache_vimeo_videos")
      self.class.define_migration("cache_vimeo_videos", cache_vimeo_video_columns, cache_vimeo_video_app_columns, cache_vimeo_video_indexes, cache_vimeo_video_app_indexes)
    rescue
      self.class.check_migration_file("*create_cache_vimeo_videos*", "create_cache_vimeo_videos.rb")
    end
    sleep(1)

    begin
      cache_tumblr_post_app_columns = ActiveRecord::Base::CacheTumblrPost.column_names
      cache_tumblr_post_app_indexes = ActiveRecord::Base.connection.indexes("cache_tumblr_posts")
      self.class.define_migration("cache_tumblr_posts", cache_tumblr_post_columns, cache_tumblr_post_app_columns, cache_tumblr_post_indexes, cache_tumblr_post_app_indexes)
    rescue
      self.class.check_migration_file("*create_cache_tumblr_posts*", "create_cache_tumblr_posts.rb")
    end
    sleep(1)

    begin
      asset_app_columns = ActiveRecord::Base::Asset.column_names
      asset_app_indexes = ActiveRecord::Base.connection.indexes("assets")
      self.class.define_migration("assets", asset_columns, asset_app_columns, asset_indexes, asset_app_indexes)
    rescue
      self.class.check_migration_file("*create_assets*", "create_assets.rb")
    end
    sleep(1)

    begin
      navigations_app_columns = ActiveRecord::Base::Navigation.column_names
      navigations_app_indexes = ActiveRecord::Base.connection.indexes("navigations")
      self.class.define_migration("navigations", navigations_columns, navigations_app_columns, navigations_indexes, navigations_app_indexes)
    rescue
      self.class.check_migration_file("*create_navigations*", "create_navigations.rb")
    end
    sleep(1)

    begin
      pages_to_navigations_app_columns = ActiveRecord::Base::PagesToNavigation.column_names
      pages_to_navigations_app_indexes = ActiveRecord::Base.connection.indexes("pages_to_navigations")
      self.class.define_migration("pages_to_navigations", pages_to_navigations_columns, pages_to_navigations_app_columns, pages_to_navigations_indexes, pages_to_navigations_app_indexes)
    rescue
      self.class.check_migration_file("*create_pages_to_navigations*", "create_pages_to_navigations.rb")
    end
    sleep(1)

    begin
      templates_app_columns = ActiveRecord::Base::Template.column_names
      templates_app_indexes = ActiveRecord::Base.connection.indexes("templates")
      self.class.define_migration("templates", templates_columns, templates_app_columns, templates_indexes, templates_app_indexes)
    rescue
      self.class.check_migration_file("*create_templates*", "create_templates.rb")
    end
    sleep(1)
    
    rake("db:migrate")
    puts self.class.end_description
  end

  class << self
    def generator
      SkinnycmsMigrationsGenerator.new
    end

    def source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
    end

    def next_migration_number(dirname)
      if ActiveRecord::Base.timestamped_migrations
        Time.new.utc.strftime("%Y%m%d%H%M%S")
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end

    def define_migration(table_name, engine_columns, application_columns, engine_indexes, application_indexes)
        migration_columns = {}
        migration_indexes = []
        application_indexes_names = []

        application_indexes.each do |value|
          application_indexes_names << value.name
        end

        engine_columns.each do |key, value|
          migration_columns["#{key}"] = value if !application_columns.include?(key.to_s)
        end

        engine_indexes.each do |value|
          migration_indexes << value if !application_indexes_names.include?(value.to_s)
        end

        if check_migration_file("*add_skinnycms_fields_to_#{table_name}.rb*", "add_skinnycms_fields_to_#{table_name}.rb")
          old_migration = Dir.glob("*add_skinnycms_fields_to_#{table_name}.rb*").first
          generator.remove_file old_migration
          generator.migration_template "add_skinnycms_fields_to_#{table_name}.rb", "add_skinnycms_fields_to_#{table_name}.rb"
        end
        
        exist_migration = Dir.glob("*add_skinnycms_fields_to_#{table_name}.rb*").first

        migration_columns.each do |key, value|
          generator.gsub_file "#{exist_migration}", "# add_column :#{table_name}, :#{key}, :#{value}", "add_column :#{table_name}, :#{key}, :#{value}"
          generator.gsub_file "#{exist_migration}", "# remove_column :#{table_name}, :#{key}", "remove_column :#{table_name}, :#{key}"
        end

        migration_indexes.each do |value|
          file = File.readlines(exist_migration)
          lines = file
          i = 0
          lines.each do |line|
            file[i] = "     " + line[6..-1] if line.include?(value)
            i += 1
          end
          real_file = File.open(exist_migration, "w")
          real_file.write(file)
          real_file.close
        end

        if migration_columns.blank? && migration_indexes.blank?
          generator.remove_file exist_migration 
          generator.say "You already have all required #{table_name} fields!", :green
        end
    end

    def check_migration_file(search_condition, migration_name)
      if Dir.glob(search_condition).count < 1
        begin
          generator.migration_template migration_name, migration_name
        rescue
        end
      else
        return true
      end
    end

    def start_description
        <<-DESCRIPTION
*******************************************************************

  SKINNYCMS: Create migrations ...

*******************************************************************
        DESCRIPTION
    end

    def end_description
        <<-DESCRIPTION
*******************************************************************

  Migrations successfully created!

*******************************************************************
        DESCRIPTION
    end
  end
end
