class Admin::PagesController < ApplicationController
 # require 'paperclip_cloudfiles_patch'
  before_filter :authenticate_user!
  before_filter :define_page
 # before_filter :update_thumbnails_for_assets, :only => [:new, :edit]
 # before_filter :generate_list_of_assets, :only => [:new, :edit]
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
    @locations = { 'header' => {}, 'content' => {}, 'sidebar' => {} }
    @loc_marks = @locations.keys
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

  def get_asset_by_type_to_editor
    sleep 2
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
    sleep 2
    assets = Asset.find( :all, :conditions => ['title LIKE ? OR description LIKE ? OR asset_file_name LIKE ?', '%' + params[:search_key] + '%', '%' + params[:search_key] + '%', '%' + params[:search_key] + '%'], :limit => 10 )
    @assets = assets.paginate :page => params[:page], :per_page => 8 if assets.present?

    respond_to do |format|
      format.js
      format.xml { head :ok }
    end
  end

  def edit
    @title = "Edit Page"
    @page = Page.find(params[:id])
    @templates = Template.all(:order => :title)
    @navigations = Navigation.all(:order => :id)
    @pages_to_navigations = PagesToNavigation.all
    @locations = @page.locations
    @loc_marks = @locations.keys
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
    Rails.logger.info "+++++++++ #{params.inspect}"
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

      # Define positions of content elements for each location

      content_types = ['UniqueContentModule','CustomModule','ApiModule','CacheTumblrPost','CacheFleakrGallery','CacheVimeoVideo']
      locations = @page.template.content_locations.split(',')

      locations.each do |location|
        positions = params["#{location}_positions"].split(',')
        values = params[location]
        content_types.each do |type|
          positions.each_with_index do |item, index|
            if item.include?(type)
              if type.eql?('UniqueContentModule')
                content = values[type][item.sub(type,"")]
                content = content.gsub!("<p>&nbsp;</p>\r\n","") if content.include?("<p>&nbsp;</p>\r\n")
              end
              PageContent.create(:page_id => @page.id,
                                 :content => content,
                                 :position => index,
                                 :location => location,
                                 :module_type => type,
                                 :module_id => item.sub(type,"").to_i)
            end
          end
        end
      end

      redirect_to(admin_pages_url, :notice => 'Page successfully created!')
    else
      redirect_to(admin_pages_url, :notice => 'Page was not created, check your input data and try again!')
    end
  end

  def update
    Rails.logger.info "+++++++++ #{params.inspect}"
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

#    # Update old contents
#
#    if params[:header_contents].present?
#      header_contents_now = []
#      params[:header_contents].each do |key, value|
#        header_content = PageContent.find(key.to_i)
#        new_position = headers_cleaned_unique_positions[key.to_i] if header_content.module_type == 'UniqueContentModule'
#        header_content.update_attributes(:content => value, :position => new_position) if header_content
#        header_contents_now << key.to_i
#      end
#      unusable_header_contents = header_contents_last - header_contents_now
#      unusable_header_contents.each { |id| PageContent.find(id).destroy }
#    else
#      header_contents_last.each { |id| PageContent.find(id).destroy }
#    end
#
#    if params[:page_contents].present?
#      page_contents_now = []
#      params[:page_contents].each do |key, value|
#        page_content = PageContent.find(key.to_i)
#        new_position = contents_cleaned_unique_positions[key.to_i] if page_content.module_type == 'UniqueContentModule'
#        page_content.update_attributes(:content => value, :position => new_position) if page_content
#        page_contents_now << key.to_i
#      end
#      unusable_page_contents = page_contents_last - page_contents_now
#      unusable_page_contents.each { |id| PageContent.find(id).destroy }
#    else
#      page_contents_last.each { |id| PageContent.find(id).destroy }
#    end
#
#    if params[:sidebar_contents].present?
#      sidebar_contents_now = []
#      params[:sidebar_contents].each do |key, value|
#        sidebar_content = PageContent.find(key.to_i)
#        new_position = sidebars_cleaned_unique_positions[key.to_i] if sidebar_content.module_type == 'UniqueContentModule'
#        sidebar_content.update_attributes(:content => value, :position => new_position) if sidebar_content
#        sidebar_contents_now << key.to_i
#      end
#      unusable_sidebar_contents = sidebar_contents_last - sidebar_contents_now
#      unusable_sidebar_contents.each { |id| PageContent.find(id).destroy }
#    else
#      sidebar_contents_last.each { |id| PageContent.find(id).destroy }
#    end

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

  private

  def define_page
    @current_page = 'pages'
  end

  def available_modules
    ApiModule.all + CustomModule.all # add another models after refactoring
  end

  def update_thumbnails_for_assets
    #FIXME - this is failing with a NoSuchObjectException: Object assets/1/original/Screen shot 2011-02-11 at 10.35.24 AM.jpg does not exist
    #Asset.all.each { |asset| asset.asset.reprocess! }
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

