class Admin::SettingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"

  def index
    @title = "Settings"
    @admin_users = User.all
    @api_modules = ApiModule.all

    basic_api_modules = ["vimeo basic", "fleakr basic", "tumblr basic"]
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

  def add_admin_settings

    redirect_to(admin_settings_path)
  end

  def add_module
    if params[:api_settings][:api_module] && params[:api_settings][:api_token] && params[:api_settings][:api_key]
      ApiModule.create!(:module_name => params[:api_settings][:api_module],
                        :module_version => 1,
                        :title => params[:api_settings][:api_module],
                        :api_token => params[:api_settings][:api_token],
                        :api_key => params[:api_settings][:api_key])
    end

    redirect_to(admin_settings_path)
  end

  def edit_module

    redirect_to(admin_settings_path)
  end

  def clear_api_cashes

    redirect_to(admin_settings_path)
  end

  private

  def define_page
    @current_page = 'settings'
  end
end

