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
    @custom_modules = CustomModule.all
    @api_modules = ApiModule.all.paginate :page => params[:page], :per_page => 2

    respond_to do |format|
      format.html
      format.xml { render :xml => @page }
    end
  end

  def edit
    @page = Page.find(params[:id])
    @page_content = PageContent.find(:first, :conditions => ["page_id = ? AND location = 'content'", @page.id])
    @sidebar_content = PageContent.find(:first, :conditions => ["page_id = ? AND location = 'sidebar'", @page.id])
    @header_content = PageContent.find(:first, :conditions => ["page_id = ? AND location = 'header'", @page.id])
    @custom_modules = CustomModule.all
    @api_modules = ApiModule.all.paginate :page => params[:page], :per_page => 2
  end

  def create   
    @page = Page.new(params[:page])

    if @page.save
      if params[:header_new].present?
        header_blocks = '';
        header_params = params[:header_new]
        header_params.each do |key, value|
          header_blocks += value
        end
        PageContent.create(:content => header_blocks, :page_id => @page.id, :location => "header")
      end

      if params[:content_new].present?
        content_blocks = '';
        content_params = params[:content_new]
        content_params.each do |key, value|
          content_blocks += value
        end
        PageContent.create(:content => content_blocks, :page_id => @page.id, :location => "content")
      end

      if params[:sidebar_new].present?
        sidebar_blocks = '';
        sidebar_params = params[:sidebar_new]
        sidebar_params.each do |key, value|
          sidebar_blocks += value
        end
        PageContent.create(:content => sidebar_blocks, :page_id => @page.id, :location => "sidebar")
      end

      redirect_to(admin_pages_url, :notice => 'Page successfully created!')
    else
      redirect_to(admin_pages_url, :notice => 'Page was not created, check your input data and try again!')
    end
  end

  def update
    @page = Page.find(params[:id])
    @page.update_attributes(params[:page])

    if params[:header_content].present? || !params[:header_new].present?
      header_exist = []
      header_exist = params[:header_content][:content] if params[:header_content][:content].present?

      if params[:header_new].present?
        header_blocks = []
        header_params = params[:header_new]
        header_params.each do |key, value|
          header_blocks << value
        end
      end

      header_result = header_exist.to_s + header_blocks.to_s

      @header_content = PageContent.find(:first, :conditions => ["page_id = ? AND location = 'header'", @page.id])

      if @header_content
        @header_content.update_attribute(:content, header_result)
      else
        PageContent.create(:content => header_result, :page_id => @page.id, :location => "header")
      end
    end

    if params[:page_content].present? || params[:content_new].present?
      content_exist = []
      content_exist = params[:page_content][:content] if params[:page_content][:content].present?

      if params[:content_new].present?
        content_blocks = []
        content_params = params[:content_new]
        content_params.each do |key, value|
          content_blocks << value
        end
      end

      content_result = content_exist.to_s + content_blocks.to_s

      @page_content = PageContent.find(:first, :conditions => ["page_id = ? AND location = 'content'", @page.id])

      if @page_content
        @page_content.update_attribute(:content, content_result)
      else
        PageContent.create(:content => content_result, :page_id => @page.id)
      end
    end

    if params[:sidebar_content].present? || params[:sidebar_new].present?
      sidebar_exist = []
      sidebar_exist = params[:sidebar_content][:content] if params[:sidebar_content][:content].present?

      if params[:sidebar_new].present?
        sidebar_blocks = []
        sidebar_params = params[:sidebar_new]
        sidebar_params.each do |key, value|
          sidebar_blocks << value
        end
      end

      sidebar_result = sidebar_exist.to_s + sidebar_blocks.to_s

      @sidebar_content = PageContent.find(:first, :conditions => ["page_id = ? AND location = 'sidebar'", @page.id])

      if @sidebar_content
        @sidebar_content.update_attribute(:content, sidebar_result)
      else
        PageContent.create(:content => sidebar_result, :page_id => @page.id, :location => "sidebar")
      end
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

