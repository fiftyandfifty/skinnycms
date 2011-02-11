class Admin::SettingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"

  def index
    @title = "Settings"
    @admin_users = User.all
    @api_modules = ApiModule.all

    basic_api_modules = ["vimeo basic", "fleakr basic", "tumblr basic", "cloudfiles storage"]
    undefined_modules = []

    if ApiModule.present?
      basic_api_modules.each do |api_module|
        current_module = ApiModule.where(:module_name => api_module)
        undefined_modules << api_module if current_module.blank?
      end
    else
      undefined_modules = basic_api_modules
    end

    @undefined_modules = []
    if undefined_modules.present?
      undefined_modules.each do |api_module|
        current_module = ApiModule.new(:module_name => api_module)
        @undefined_modules << current_module
      end
    end
  end

  def edit_admin_settings
    if params[:admin_settings][:user] && params[:admin_settings][:login] && params[:admin_settings][:password]
      admin_user = User.find(params[:admin_settings][:user])
      admin_user.update_attributes(:email => params[:admin_settings][:login],
                                   :password => params[:admin_settings][:password],
                                   :password_confirmation => params[:admin_settings][:password],
                                   :confirmed_at => Time.now)
    end

    redirect_to(admin_settings_path)
  end

  def add_module
    if params[:api_settings][:api_module] && params[:api_settings][:api_token] && params[:api_settings][:api_key]
      api_hash = { :api_token => params[:api_settings][:api_token], :api_key => params[:api_settings][:api_key] }
      api_hash[:container] = params[:api_settings][:container] if params[:api_settings][:container].present?
      api_configurations = api_hash.to_json
      api_module = ApiModule.create!(:module_name => params[:api_settings][:api_module],
                        :module_version => 1,
                        :title => params[:api_settings][:api_module],
                        :configuration => api_configurations)
                      
      api_module.define_cloudfiles_configuration if params[:api_settings][:container].present?
    end
    
    redirect_to(admin_settings_path)
  end

  def edit_module
    if params[:api_settings][:api_module] && params[:api_settings][:api_token] && params[:api_settings][:api_key]
      api_module = ApiModule.find(params[:api_settings][:api_module])
      api_hash = { :api_token => params[:api_settings][:api_token], :api_key => params[:api_settings][:api_key] }
      api_hash[:container] = params[:api_settings][:container] if params[:api_settings][:container].present?
      api_configurations = api_hash.to_json
      api_module.update_attribute(:configuration, api_configurations) if api_module

      api_module.define_cloudfiles_configuration if params[:api_settings][:container].present?
    end

    redirect_to(admin_settings_path)
  end

  def clear_api_cashes
    vimeo_module = ApiModule.find_by_module_name('vimeo basic')
    fleakr_module = ApiModule.find_by_module_name('fleakr basic')
    tumblr_module = ApiModule.find_by_module_name('tumblr basic')

    Admin::VideosController.new.update_cached_videos if vimeo_module.present?
    Admin::GalleriesController.new.update_cached_galleries if fleakr_module.present?
    Admin::PostsController.new.update_cached_posts if tumblr_module.present?

    redirect_to(admin_settings_path)
  end

  private

  def define_page
    @current_page = 'settings'
  end
end

