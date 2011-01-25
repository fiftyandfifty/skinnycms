class Admin::AssetsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"

  def index
    @title = "Assets"
    @assets = Asset.all
    @videos = CacheVimeoVideo.find(:all, :conditions => "incomplete != 1")
    @galleries = CacheFleakrGallery.find(:all, :conditions => "incomplete != 1")

    respond_to do |format|
      format.html
      format.xml  { render :xml => @assets }
    end
  end

  def show
    @asset = Asset.find(params[:id])

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
  
  def search
    @searched_assets = Asset.find( :all, :conditions => ['title LIKE ? OR description LIKE ? OR asset_file_name LIKE ?', '%' + params[:search_key] + '%'], :limit => 10 )

    respond_to do |format|
      format.html { redirect_to(admin_assets_path(:searched_assets => @searched_assets)) }
      format.xml  { render :xml => @searched_assets }
    end
  end

  private

  def define_page
    @current_page = 'assets'
  end
end

