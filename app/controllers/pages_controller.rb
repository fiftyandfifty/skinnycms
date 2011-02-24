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

    if @page.page_contents.where(:module_type => 'Tumblr Basic').present?
      tumblr_basic_module = ApiModule.where(:module_name => 'tumblr basic').first
      recent_posts_number = JSON.parse(tumblr_basic_module.configuration)["recent_posts_number"].to_i
      @detail_page_path = JSON.parse(tumblr_basic_module.configuration)["detail_page_path"]
      @all_tumblr_posts = CacheTumblrPost.all.paginate :page => params[:page], :per_page => recent_posts_number
      @recent_tumblr_posts = CacheTumblrPost.order('post_date asc').limit(recent_posts_number)
    end

    respond_to do |format|
      format.html { render :layout => page_template }
      format.xml  { render :xml => @page }
    end
  end
end
