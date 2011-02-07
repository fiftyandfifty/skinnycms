class PagesController < ApplicationController

  layout 'front_end'
  
  def index    
    @page = Page.where(:title => 'home')
    @header_contents = PageContent.where(:page_id => @page, :location => 'header').order(:position)
    @page_contents = PageContent.where(:page_id => @page, :location => 'content').order(:position)
    @sidebar_contents = PageContent.where(:page_id => @page, :location => 'sidebar').order(:position)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @page }
    end
  end
  
  def show
    @page = Page.find(params[:id])
    @header_contents = PageContent.where(:page_id => @page, :location => 'header').order(:position)
    @page_contents = PageContent.where(:page_id => @page, :location => 'content').order(:position)
    @sidebar_contents = PageContent.where(:page_id => @page, :location => 'sidebar').order(:position)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @page }
    end
  end
end
