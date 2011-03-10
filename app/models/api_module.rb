class ApiModule < ActiveRecord::Base
  cattr_accessor :api_key, :api_token
  validates :module_name, :presence => true

  def unique_id
    id
  end

  def api_key
    JSON.parse(self.configuration)['api_token']
  end

  def api_token
    JSON.parse(self.configuration)['api_token']
  end

  def detail_page_path
    JSON.parse(self.configuration)['detail_page_path']
  end

  def recent_posts_number
    JSON.parse(self.configuration)['recent_posts_number']
  end

  class << self
    def undefined_modules
      basic_api_modules = []
      undefined_modules = []
      @undefined_modules = []

      basic_api_modules = ['tumblr basic','fleakr basic','vimeo basic']

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
