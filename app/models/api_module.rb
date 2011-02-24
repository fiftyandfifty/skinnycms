class ApiModule < ActiveRecord::Base
  cattr_accessor :api_key, :api_token
  validates :module_name, :presence => true

  class << self
    def undefined_modules
      basic_api_modules = []
      undefined_modules = []
      @undefined_modules = []

      Dir.chdir("#{RAILS_ROOT}/")
      gemfile = IO.read('Gemfile')
      basic_api_modules << 'tumblr basic' if gemfile.scan("skinnycms_tumblr").size > 0
      basic_api_modules << 'fleakr basic' if gemfile.scan("skinnycms_fleakr").size > 0
      basic_api_modules << 'vimeo basic' if gemfile.scan("skinnycms_vimeo").size > 0

      if ApiModule.present?
        basic_api_modules.each do |api_module|
          current_module = ApiModule.where(:module_name => api_module)
          undefined_modules << api_module if current_module.blank?
        end
      else
        undefined_modules = basic_api_modules
      end

      if undefined_modules.present?
        undefined_modules.each do |api_module|
          current_module = ApiModule.new(:module_name => api_module)
          @undefined_modules << current_module
        end
      end

      @undefined_modules
    end

    def undefined_modules_names
      undefined_modules.map{ |api_module| api_module.module_name }
    end
  end
end
