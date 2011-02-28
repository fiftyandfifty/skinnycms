class Admin::SettingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"

  def index
    @title = "Settings"
    @admin_users = User.all
    @settings = Setting.all
    @undefined_modules_names = ApiModule.undefined_modules_names

    basic_settings = ['Rackspace Cloudfiles']
    undefined_settings = []
    @undefined_settings = []

    if Setting.present?
      basic_settings.each do |setting|
        current_setting = Setting.where(:title => setting)
        undefined_settings << setting if current_setting.blank?
      end
    else
      undefined_settings = basic_settings
    end

    if undefined_settings.present?
      undefined_settings.each do |setting|
        current_setting = Setting.new(:title => setting)
        @undefined_settings << current_setting
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

  def add_setting
    if params[:api_settings][:setting] && params[:api_settings][:api_token] && params[:api_settings][:api_key]
      api_hash = { :api_token => params[:api_settings][:api_token], :api_key => params[:api_settings][:api_key] }
      api_hash[:container] = params[:api_settings][:container] if params[:api_settings][:container].present?
      api_configurations = api_hash.to_json
      Setting.create!(:title => params[:api_settings][:setting],
                    :configuration => api_configurations)
    end
    
    redirect_to(admin_settings_path)
  end

  def edit_setting
    if params[:api_settings][:setting] && params[:api_settings][:api_token] && params[:api_settings][:api_key]
      setting = Setting.find(params[:api_settings][:setting])
      api_hash = { :api_token => params[:api_settings][:api_token], :api_key => params[:api_settings][:api_key] }
      api_hash[:container] = params[:api_settings][:container] if params[:api_settings][:container].present?
      api_configurations = api_hash.to_json
      setting.update_attribute(:configuration, api_configurations) if setting
    end

    redirect_to(admin_settings_path)
  end

  def destroy
    setting = Setting.find(params[:id])
    setting.destroy

    respond_to do |format|
      format.html { redirect_to(admin_settings_url, :notice => 'Setting successfully deleted!') }
      format.xml  { head :ok }
    end
  end

  private

  def define_page
    @current_page = 'settings'
  end
end

