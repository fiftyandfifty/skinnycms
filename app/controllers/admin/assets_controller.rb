class Admin::AssetsController < ApplicationController
  require 'paperclip_cloudfiles_patch'
  before_filter :authenticate_user!
  before_filter :define_page
  uses_tiny_mce
  layout "admin"

  def index
    @title = "Assets"

    if params[:asset_type].present?
      @asset_type = params[:asset_type]
    elsif params[:asset_type].blank? && params[:search].blank?
      @asset_type = 'all'
    end

    if params[:assets].present?
      @assets = Asset.find(params[:assets])
    elsif @asset_type == 'all'
      @assets = Asset.all
    end

    @assets = @assets.paginate :page => params[:page], :per_page => 10 if @assets.present?
    @undefined_modules_names = ApiModule.undefined_modules_names

    respond_to do |format|
      format.html
      format.xml  { render :xml => @assets }
    end
  end

  def show
    @asset = Asset.find(params[:id])
    @asset.asset.reprocess!

    respond_to do |format|
      format.html
      format.xml  { render :xml => @asset }
    end
  end

  def new
    @asset = Asset.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @asset }
    end
  end

  def edit
    @asset = Asset.find(params[:id])
  end

  def create
    @asset = Asset.new(params[:asset])

    respond_to do |format|
      if @asset.save
        format.html { redirect_to(admin_assets_path, :notice => 'Asset was successfully created.') }
        format.xml  { render :xml => @asset, :status => :created, :location => @asset }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @asset = Asset.find(params[:id])

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        format.html { redirect_to(admin_assets_path, :notice => 'Asset was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to(admin_assets_path) }
      format.xml  { head :ok }
    end
  end
  
  def search_asset
    if params[:search][:key].present?
      @assets = Asset.find( :all, :conditions => ['title LIKE ? OR description LIKE ? OR asset_file_name LIKE ?', '%' + params[:search][:key] + '%', '%' + params[:search][:key] + '%', '%' + params[:search][:key] + '%'], :limit => 10 )
    else
      @assets = []
    end

    respond_to do |format|
      format.html { redirect_to(admin_assets_path(:assets => @assets, :search => true)) }
      format.xml  { render :xml => @assets }
    end
  end

  def get_asset_by_type
    if params[:asset_type].present?
      @assets = Asset.find(:all, :conditions => ['asset_content_type LIKE ?', '%' + params[:asset_type] + '%'])
    else
      @assets = []
    end

    respond_to do |format|
      format.html { redirect_to(admin_assets_path(:assets => @assets, :asset_type => params[:asset_type])) }
      format.xml  { head :ok }
    end
  end

  private

  def define_page
    @current_page = 'assets'
  end
end

