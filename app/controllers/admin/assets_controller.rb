class Admin::AssetsController < ApplicationController
 # before_filter :authenticate_user!
  before_filter :define_page
  uses_tiny_mce
  layout "admin"

  def index
    Rails.logger.info "++++++++++ #{params.inspect}"
    @title = "Assets"

    if params[:assets]
      @assets = Asset.find(params[:assets])
      Rails.logger.info "++++++++++ YA"
    else
      @assets = Asset.all
      Rails.logger.info "++++++++++ NO"
    end

    if params[:asset_type].present?
      @asset_type = params[:asset_type]
    else
      @asset_type = 'all'
    end
    
    Rails.logger.info "++++++++++ #{@assets}"
    Rails.logger.info "++++++++++ #{@asset_type}"
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

  def get_asset_by_type
    Rails.logger.info "++++++++++ #{params.inspect}"

    if params[:asset_type].present?
      @assets = Asset.find(:all, :conditions => ['asset_content_type LIKE ?', '%' + params[:asset_type] + '%'])
      Rails.logger.info "++++++++++++ YA"
    else
      @assets = Asset.all
      Rails.logger.info "++++++++++++ NO"
    end

    Rails.logger.info "++++++++++ #{@assets}"
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

