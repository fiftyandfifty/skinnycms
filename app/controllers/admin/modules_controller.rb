class Admin::ModulesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"

  def index
    @title = "Modules"
    @custom_modules = CustomModule.all
    @api_modules = ApiModule.all
    @undefined_modules = ApiModule.undefined_modules
    @undefined_modules_names = ApiModule.undefined_modules_names

    respond_to do |format|
      format.html
    end
  end

  def add_module
    if params[:api_settings][:api_module] && params[:api_settings][:api_token] && params[:api_settings][:api_key]
      api_hash = { :api_token => params[:api_settings][:api_token], :api_key => params[:api_settings][:api_key] }
      api_hash[:recent_posts_number] = params[:api_settings][:recent_posts_number] if params[:api_settings][:recent_posts_number].present?
      api_hash[:detail_page_path] = params[:api_settings][:detail_page_path] if params[:api_settings][:detail_page_path].present?
      api_configurations = api_hash.to_json
      ApiModule.create!(:module_name => params[:api_settings][:api_module],
                        :module_version => 1,
                        :title => params[:api_settings][:api_module],
                        :configuration => api_configurations)
    end

    redirect_to(admin_modules_path)
  end

  def edit_module
    if params[:api_settings][:api_module] && params[:api_settings][:api_token] && params[:api_settings][:api_key]
      api_module = ApiModule.find(params[:api_settings][:api_module])
      api_hash = { :api_token => params[:api_settings][:api_token], :api_key => params[:api_settings][:api_key] }
      api_hash[:recent_posts_number] = params[:api_settings][:recent_posts_number] if params[:api_settings][:recent_posts_number].present?
      api_hash[:detail_page_path] = params[:api_settings][:detail_page_path] if params[:api_settings][:detail_page_path].present?
      api_configurations = api_hash.to_json
      api_module.update_attribute(:configuration, api_configurations) if api_module
    end

    redirect_to(admin_modules_path)
  end

  def clear_api_cashes
    vimeo_module = ApiModule.find_by_module_name('vimeo basic')
    fleakr_module = ApiModule.find_by_module_name('fleakr basic')
    tumblr_module = ApiModule.find_by_module_name('tumblr basic')

    Admin::VideosController.new.update_cached_videos if vimeo_module.present?
    Admin::GalleriesController.new.update_cached_galleries if fleakr_module.present?
    Admin::PostsController.new.update_cached_posts if tumblr_module.present?

    redirect_to(admin_modules_path)
  end

  private

  def define_page
    @current_page = 'modules'
  end
end

