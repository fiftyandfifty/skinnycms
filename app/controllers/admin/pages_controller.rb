class Admin::PagesController < ApplicationController

  before_filter :authenticate_user!
  layout "application"
 # uses_tiny_mce
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
    @page = type_error_fix(params[:id]) if @page.blank?

    respond_to do |format|
      format.html
      format.xml  { render :xml => @page }
    end
  end

  def new
    @title = "Add Page"
    @page = Page.new
    @page_content = PageContent.new

    respond_to do |format|
      format.html
      format.xml { render :xml => @page }
    end
  end

  def edit
    @page = Page.find(params[:id]) rescue nil
    @page = type_error_fix(params[:id]) if @page.blank?
    @page_content = PageContent.find(:first, :conditions => ["page_id = ?", @page.id])
    @category = CategoryItem.find(:first, :conditions => "categorizable_type = 'Page' AND categorizable_id = #{@page.id}")
    @sidebar_content = PageContent.find(:first, :conditions => ["page_id = ? AND location = 'sidebar'", @page.id])
  end

  def create
    @page = Page.new(params[:page])

    if @page.save
      PageContent.create(:content => params[:page_content][:content], :page_id => @page.id, :location => "content") if params[:page_content][:content]
      PageContent.create(:content => params[:sidebar_content][:content], :page_id => @page.id, :location => "sidebar") if params[:sidebar_content][:content]
      CategoryItem.create(:category_id => params[:category][:category_id], :categorizable_id => @page.id, :categorizable_type => "page") if params[:category][:category_id]

      redirect_to(admin_pages_url, :notice => 'Page successfully created!')
    else
      redirect_to(admin_pages_url, :notice => 'Page was not created, check your input data and try again!')
    end
  end

  def update
    @page = Page.find(params[:id]) rescue nil
    @page = type_error_fix(params[:id]) if @page.blank?
    @page.update_attributes(params[:page])

    @page_content = PageContent.find(:first, :conditions => ["page_id = ?", @page.id])
    @category_item = CategoryItem.find(:first, :conditions => "categorizable_type = 'page' AND categorizable_id = #{@page.id}")

    if @category_item
      @category_item.update_attributes(:category_id => params[:category][:category_id], :categorizable_id => @page.id, :categorizable_type => "page")
    else
      CategoryItem.create(:category_id => params[:category][:category_id], :categorizable_id => @page.id, :categorizable_type => "page")
    end

    if @page_content
      @page_content.update_attributes(params[:page_content])
    else
      PageContent.create(:content => params[:page_content][:content], :page_id => @page.id)
    end

    @sidebar_content = PageContent.find(:first, :conditions => ["page_id = ? AND location = 'sidebar'", @page.id])
    if @sidebar_content
      @sidebar_content.update_attributes(params[:sidebar_content])
    else
      PageContent.create(:content => params[:sidebar_content][:content], :page_id => @page.id, :location => "sidebar")
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
end