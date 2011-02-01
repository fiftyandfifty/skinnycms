class PagesController < ApplicationController

  layout 'front_end'
  
  def index    
    @page = Page.where(:title => 'home')
    @header_contents = PageContent.where(:page_id => @page, :location => 'header')
    @page_contents = PageContent.where(:page_id => @page, :location => 'content')
    @sidebar_contents = PageContent.where(:page_id => @page, :location => 'sidebar')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @page }
    end
  end
  
  def show
    @page = Page.find(params[:id])
    @header_contents = PageContent.where(:page_id => @page, :location => 'header')
    @page_contents = PageContent.where(:page_id => @page, :location => 'content')
    @sidebar_contents = PageContent.where(:page_id => @page, :location => 'sidebar')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @page }
    end
  end
end
