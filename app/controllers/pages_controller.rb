class PagesController < ApplicationController
  
  def index    
    @page = Page.where(:title => 'Home').first
    locations = []
    locations = @page.template.content_locations.split(',') if @page.template.content_locations.present?
    @header_contents = PageContent.where(:page_id => @page, :location => 'header').order(:position) if locations.include?('header')
    @page_contents = PageContent.where(:page_id => @page, :location => 'content').order(:position) if locations.include?('content')
    @sidebar_contents = PageContent.where(:page_id => @page, :location => 'sidebar').order(:position) if locations.include?('sidebar')

    respond_to do |format|
      format.html { render :layout  => 'home_page' }
      format.xml  { render :xml => @page }
    end
  end
  
  def show
    @page = Page.find(params[:id])
    locations = []
    locations = @page.template.content_locations.split(',') if @page.template.content_locations.present?
    @header_contents = PageContent.where(:page_id => @page, :location => 'header').order(:position) if locations.include?('header')
    @page_contents = PageContent.where(:page_id => @page, :location => 'content').order(:position) if locations.include?('content')
    @sidebar_contents = PageContent.where(:page_id => @page, :location => 'sidebar').order(:position) if locations.include?('sidebar')
    if @page.template.title == 'Detail Page'
      layout_name = 'detail_page'
    elsif @page.template.title == 'Landing Page'
      layout_name = 'landing_page'
    else
      layout_name = 'home_page'
    end

    respond_to do |format|
      format.html { render :layout  => layout_name }
      format.xml  { render :xml => @page }
    end
  end
end
