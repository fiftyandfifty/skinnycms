class Admin::AssetsController < ApplicationController
 # before_filter :authenticate_user!
  before_filter :define_page
  uses_tiny_mce
  layout "admin"

  def index
    @title = "Assets"

    if params[:assets] || params[:searched_assets]
      @assets = Asset.find(params[:searched_assets]) if params[:searched_assets]
      @assets = Asset.find(params[:assets]) if params[:assets]
    else
      @assets = Asset.all
    end

    if params[:asset_type].present?
      @asset_type = params[:asset_type]
    else
      @asset_type = 'all'
    end

    @assets = @assets.paginate :page => params[:page], :per_page => 10
    @videos = CacheVimeoVideo.find(:all, :conditions => "incomplete != 1")
    @galleries = CacheFleakrGallery.find(:all, :conditions => "incomplete != 1")

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
    @searched_assets = Asset.find( :all, :conditions => ['title LIKE ? OR description LIKE ? OR asset_file_name LIKE ?', '%' + params[:search][:key] + '%', '%' + params[:search][:key] + '%', '%' + params[:search][:key] + '%'], :limit => 10 )

    respond_to do |format|
      format.html { redirect_to(admin_assets_path(:searched_assets => @searched_assets)) }
      format.xml  { render :xml => @searched_assets }
    end
  end

  def get_asset_by_type
    if params[:asset_type].present?
      @assets = Asset.find(:all, :conditions => ['asset_content_type LIKE ?', '%' + params[:asset_type] + '%'])
    else
      @assets = Asset.all
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

