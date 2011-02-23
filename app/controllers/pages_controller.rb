class PagesController < ApplicationController
  def index
    show
  end
  
  def show
    if params
      if params[:id].blank? then page_id = 1 else page_id = params[:id] end
    else
      page_id = 1
    end
    @page = Page.find(page_id)
    
    if !@page.redirect_url.blank?
      redirect_to @page.redirect_url
      return
    end
    
    locations = []
    if @page.template.present?
      locations = @page.template.content_locations.split(',') if @page.template.content_locations.present?
      page_template = @page.template.title.downcase.gsub(" ", "_")
    end
    page_template = 'home_page' if !page_template
    
    @header_contents = PageContent.where(:page_id => @page, :location => 'header').order(:position) if locations.include?('header')
    @page_contents = PageContent.where(:page_id => @page, :location => 'content').order(:position) if locations.include?('content')
    @sidebar_contents = PageContent.where(:page_id => @page, :location => 'sidebar').order(:position) if locations.include?('sidebar')

    respond_to do |format|
      format.html { render :layout => page_template }
      format.xml  { render :xml => @page }
    end
  end
end
