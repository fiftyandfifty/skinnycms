class Admin::PagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  before_filter :generate_list_of_assets, :only => [:new, :edit]
  layout "admin"
  uses_tiny_mce :options => {:theme_advanced_buttons1_add => %w{assets}},
                :raw_options => "setup : function(ed) { ed.addButton('assets', { title : 'Assets', image : '/images/skinnycms/admin/assets.gif', onclick : function() { var my_id = $(this).attr('id'); $('#wysiwyg_container').text(my_id); $('#assets_popup').dialog('open'); }});}"
  respond_to :html, :xml

  def index
    @title = "Pages"

    @nav_names = {}
    @navigations = {}
    @navs = Navigation.all(:order => :id)
    @navs.each do |nav|
      @nav_names[nav.id] = nav.title
      @navigations[nav.id] = PagesToNavigation.public_and_redirect_in_root_for(nav.title)
    end

    @private_pages = []
    not_on_nav = Page.not_on_nav
    not_on_nav.each do |p|
      @private_pages << PagesToNavigation.new(:page_id => p.id)
    end

    @undefined_modules_names = ApiModule.undefined_modules_names

    respond_to do |format|
      format.html
      format.xml  { render :xml => @pages }
    end
  end

  def show
    @page = Page.find(params[:id]) rescue nil

    respond_to do |format|
      format.html
      format.xml  { render :xml => @page }
    end
  end

  def new
    @title = "Add Page"
    @page = Page.new
    @page_content = PageContent.new
    @templates = Template.all(:order => :title)
    @navigations = Navigation.all(:order => :title)
    @pages_to_navigations = PagesToNavigation.all
    @locations = Template.all_locations
    @loc_marks = @locations.keys
    @templates_hash = Template.templates_hash
    @available_modules = available_modules.paginate :page => params[:page], :per_page => 10
    @assets = Asset.all.paginate :page => params[:page], :per_page => 8
    @asset_types = Asset.types
    @last_id = PageContent.last.id

    respond_to do |format|
      format.html
      format.js
      format.xml { render :xml => @page }
    end
  end

  def edit
    @title = "Edit Page"
    @page = Page.find(params[:id])
    @templates = Template.all(:order => :title)
    @navigations = Navigation.all(:order => :id)
    @pages_to_navigations = PagesToNavigation.all
    @locations = @page.exist_and_other_locations
    @loc_marks = @locations.keys
    @templates_hash = Template.templates_hash
    @available_modules = available_modules.paginate :page => params[:page], :per_page => 10
    @assets = Asset.all.paginate :page => params[:page], :per_page => 8
    @asset_types = Asset.types
    @last_id = PageContent.last.id

    respond_to do |format|
      format.html
      format.js
      format.xml { render :xml => @page }
    end
  end

  def create
    @page = Page.new(params[:page])

    if @page.save

      # Define navigations

      params[:navigation].each do |nav_id, value|
        if value.present?
          parent_id = value == 'root' ? 0 : value.to_i
          PagesToNavigation.create(:navigation_id => nav_id.to_i, :page_id => @page.id, :parent_id => parent_id)
        end
      end
      @page.update_attribute(:template_id, Template.find(:first, :conditions => { :title => 'Home Page' }).id) if params[:page][:template_id].blank?

      # Define positions of content elements for each location and create new page_contents
      
      if @page.template 
        locations = @page.template.content_locations.split(',')
      else
        locations = []
      end

      locations.each do |location|
        @page.define_contents(location, params["#{location}_positions"].split(','), params[location])
      end

      redirect_to(admin_pages_url, :notice => 'Page successfully created!')
    else
      redirect_to(admin_pages_url, :notice => 'Page was not created, check your input data and try again!')
    end
  end

  def update
    @page = Page.find(params[:id])
    @page.update_attributes(params[:page])

    # Define navigations

    params[:navigation].each do |nav_id, value|
      pages_to_navigation = PagesToNavigation.find(:first, :conditions => { :navigation_id => nav_id, :page_id => @page.id })
      if value.present?
        parent_id = value == 'root' ? 0 : value.to_i
        if pages_to_navigation.present?
          pages_to_navigation.update_attribute(:parent_id, parent_id)
        else
          PagesToNavigation.create(:navigation_id => nav_id.to_i, :page_id => @page.id, :parent_id => parent_id)
        end
      else
        pages_to_navigation.delete if pages_to_navigation.present?
      end
    end

    # Delete exist page_contents

    @page.page_contents.delete_all # TODO: make it by updating

    # Define positions of content elements for each location and create new page_contents

    if @page.template 
      locations = @page.template.content_locations.split(',')
    else
      locations = []
    end

    locations.each do |location|
      @page.define_contents(location, params["#{location}_positions"].split(','), params[location])
    end

    respond_to do |format|
      format.html { redirect_to(admin_pages_url, :notice => 'Page successfully updated!') }
      format.xml { head :ok }
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(admin_pages_url, :notice => 'Page successfully deleted!') }
      format.xml  { head :ok }
    end
  end

  def update_sort
    pages = params[:pages]

    # deleting not usable root element of sortable array
    pages.delete('0')

    # define parent elements, which located in a root of sortable list
    pages.each do |key, value|
      page_to_navigation = PagesToNavigation.find(value['item_id'].to_i)
      page = page_to_navigation.page
      page.update_attribute(:permalink, "undefined") if page.permalink.blank?
      if value['parent_id'].to_i > 0
        page_to_navigation.update_attributes(:position => key.to_i, :parent_id => value['parent_id'].to_i)
      else
        page_to_navigation.update_attributes(:position => key.to_i, :parent_id => 0)
      end
    end

    render :nothing => true
  end

  def get_asset_by_type_to_editor
    if params[:asset_type].present? && params[:asset_type] != 'all'
      assets = Asset.find(:all, :conditions => ['asset_content_type LIKE ?', '%' + params[:asset_type] + '%'])
    elsif params[:asset_type] == 'all'
      assets = Asset.all
    end
    @assets = assets.paginate :page => params[:page], :per_page => 8 if assets.present?

    respond_to do |format|
      format.js
      format.xml { head :ok }
    end
  end

  def search_asset_for_editor
    assets = Asset.find( :all, :conditions => ['title LIKE ? OR description LIKE ? OR asset_file_name LIKE ?', '%' + params[:search_key] + '%', '%' + params[:search_key] + '%', '%' + params[:search_key] + '%'], :limit => 10 )
    @assets = assets.paginate :page => params[:page], :per_page => 8 if assets.present?

    respond_to do |format|
      format.js
      format.xml { head :ok }
    end
  end

  private

  def define_page
    @current_page = 'pages'
  end

  def available_modules
    ApiModule.all + CustomModule.all + CacheTumblrPost.all + CacheVimeoVideo.all + CacheFleakrGallery.all
  end

  def generate_list_of_assets
    images_list = "var tinyMCEImageList = new Array("
    i = Asset.count
    Asset.image_list.each do |key, value|
      asset_url = "[" + "\'" + key.to_s + "\'" + "," + "\'" + value.to_s + "\'" + "]"
      asset_url += "," if i > 1
      images_list += asset_url
      i -= 1
    end
    images_list += ");"
    f = File.open("#{Rails.root}/public/javascripts/tiny_mce/image_list.js",'w+')
    f.write(images_list)
    f.close
  end
end

