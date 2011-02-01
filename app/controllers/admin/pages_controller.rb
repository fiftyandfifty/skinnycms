class Admin::PagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"
  uses_tiny_mce
  respond_to :html, :xml

  def index
    @title = "Pages"

    @pages = Page.public_and_redirect_in_root
    @private_pages = Page.private_in_root

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
    
    available_modules = CustomModule.all + CacheTumblrPost.all + CacheVimeoVideo.all + CacheFleakrGallery.all
    @available_modules = available_modules.paginate :page => params[:page], :per_page => 10

    respond_to do |format|
      format.html
      format.xml { render :xml => @page }
    end
  end

  def edit
    @title = "Edit Page"
    @page = Page.find(params[:id])

    @header_contents = PageContent.where(:page_id => @page, :location => 'header')
    @page_contents = PageContent.where(:page_id => @page, :location => 'content')
    @sidebar_contents = PageContent.where(:page_id => @page, :location => 'sidebar')

    available_modules = CustomModule.all + CacheTumblrPost.all + CacheVimeoVideo.all + CacheFleakrGallery.all
    @available_modules = available_modules.paginate :page => params[:page], :per_page => 10
  end

  def create
    @page = Page.new(params[:page])

    if @page.save
      params[:header_new].each { |key, value| PageContent.create(:content => value, :page_id => @page.id, :location => "header") } if params[:header_new].present?

      if params[:content_new].present?
        cleaned_values = []
        uncleaned_values = params[:content_new]
        keys = uncleaned_values.keys.sort{ |a,b| a.to_i <=> b.to_i }
        keys.each do |key|
          value = uncleaned_values["#{key.to_s}"]
          if value.include?("<p>&nbsp;</p>\r\n")
            cleaned_value = value.gsub!("<p>&nbsp;</p>\r\n","")
          else
            cleaned_value = value
          end
          cleaned_values << cleaned_value
        end
        cleaned_values.each { |value| PageContent.create(:content => value, :page_id => @page.id, :location => "content") }
      end

      params[:sidebar_new].each { |key, value| PageContent.create(:content => value, :page_id => @page.id, :location => "sidebar") } if params[:sidebar_new].present?

      redirect_to(admin_pages_url, :notice => 'Page successfully created!')
    else
      redirect_to(admin_pages_url, :notice => 'Page was not created, check your input data and try again!')
    end
  end

  def update
    @page = Page.find(params[:id])
    @page.update_attributes(params[:page])

    if params[:header_contents].present?
      header_contents_last = PageContent.where(:page_id => @page, :location => "header").map { |value| value.id }
      header_contents_now = []
      params[:header_contents].each do |key, value|
        @header_content = PageContent.find(key.to_i)
        if @header_content
          @header_content.update_attribute(:content, value)
        else
          PageContent.create(:content => value, :page_id => @page.id, :location => "header")
        end
        header_contents_now << key.to_i
      end
      unusable_header_contents = header_contents_last - header_contents_now
      unusable_header_contents.each { |id| PageContent.find(id).destroy }
    else
      PageContent.where(:page_id => @page, :location => "header").delete_all
    end

    if params[:page_contents].present?
      page_contents_last = PageContent.where(:page_id => @page, :location => "content").map { |value| value.id }
      page_contents_now = []
      params[:page_contents].each do |key, value|
        @page_content = PageContent.find(key.to_i)
        if @page_content
          @page_content.update_attribute(:content, value)
        else
          PageContent.create(:content => value, :page_id => @page.id, :location => "content")
        end
        page_contents_now << key.to_i
      end
      unusable_page_contents = page_contents_last - page_contents_now
      unusable_page_contents.each { |id| PageContent.find(id).destroy }
    else
      PageContent.where(:page_id => @page, :location => "content").delete_all
    end

    if params[:sidebar_contents].present?
      sidebar_contents_last = PageContent.where(:page_id => @page, :location => "sidebar").map { |value| value.id }
      sidebar_contents_now = []
      params[:sidebar_contents].each do |key, value|
        @sidebar_content = PageContent.find(key.to_i)
        if @sidebar_content
          @sidebar_content.update_attribute(:content, value)
        else
          PageContent.create(:content => value, :page_id => @page.id, :location => "sidebar")
        end
        sidebar_contents_now << key.to_i
      end
      unusable_sidebar_contents = sidebar_contents_last - sidebar_contents_now
      unusable_sidebar_contents.each { |id| PageContent.find(id).destroy }
    else
      PageContent.where(:page_id => @page, :location => "sidebar").delete_all
    end

    params[:header_new].each { |key, value| PageContent.create(:content => value, :page_id => @page.id, :location => "header") } if params[:header_new].present?
    params[:content_new].each { |key, value| PageContent.create(:content => value, :page_id => @page.id, :location => "content") } if params[:content_new].present?
    params[:sidebar_new].each { |key, value| PageContent.create(:content => value, :page_id => @page.id, :location => "sidebar") } if params[:sidebar_new].present?
    
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
      page = Page.find(value['item_id'].to_i)
      page.update_attribute(:permalink, "undefined") if page.permalink.blank?
      if value['parent_id'].to_i > 0
        page.update_attributes(:position => key.to_i, :parent_id => value['parent_id'].to_i)
      else
        page.update_attributes(:position => key.to_i, :parent_id => nil)
      end
    end

    render :nothing => true
  end

  private

  def define_page
    @current_page = 'pages'
  end
end

