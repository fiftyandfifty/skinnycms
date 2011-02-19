class PagesController < ApplicationController
  def index
    @page = Page.find(1)    
    show
  end
  
  def show
    @page = Page.find(params[:id]) unless @page
    
    if !@page.redirect_url.blank?
      redirect_to @page.redirect_url
      return
    end
    
    locations = []
    locations = @page.template.content_locations.split(',') if @page.template.content_locations.present?
    
    @header_contents = PageContent.where(:page_id => @page, :location => 'header').order(:position) if locations.include?('header')
    @page_contents = PageContent.where(:page_id => @page, :location => 'content').order(:position) if locations.include?('content')
    @sidebar_contents = PageContent.where(:page_id => @page, :location => 'sidebar').order(:position) if locations.include?('sidebar')
    
    page_template = @page.template.title.downcase.gsub(" ", "_")
    page_template = 'home_page' if !template_exists?(page_template, "pages")

    respond_to do |format|
      format.html { render :layout => page_template }
      format.xml  { render :xml => @page }
    end
  end
end
