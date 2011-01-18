class Admin::ApiModulesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"

  def index
    @title = "Modules"
  end

  def destroy
    @api_module = ApiModule.find(params[:id])
    @api_module.destroy

    if @api_module.module_name == 'vimeo basic'
      CacheVimeoVideo.delete_all
    elsif @api_module.module_name == 'fleakr basic'
      CacheFleakrGallery.delete_all
    elsif @api_module.module_name == 'tumblr basic'
      CacheTumblrPost.delete_all
    end

    respond_to do |format|
      format.html { redirect_to(admin_settings_url, :notice => 'Api module successfully deleted!') }
      format.xml  { head :ok }
    end
  end

  private

  def define_page
    @current_page = 'modules'
  end
end

