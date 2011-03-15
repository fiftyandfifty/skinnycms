class PagesController < ApplicationController

  def index
    show
  end
 
  def show
    Admin::GalleriesController.new.login_and_get_fleakr_user

    if params
      if params[:id].blank? then page_id = Page.new.get_home_page_id else page_id = params[:id] end
    else
      page_id = Page.new.get_home_page_id
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
    
    @content_locations = {}
    locations.each do |loc|
      @content_locations[loc] = PageContent.where(:page_id => @page, :location => loc).order(:position)
    end
    
    ApiModule.all.each do |api_module|
      if api_module.module_name == 'tumblr basic'
        recent_posts_number = JSON.parse(api_module.configuration)["recent_posts_number"].to_i
        @tumblr_detail_page_path = JSON.parse(api_module.configuration)["detail_page_path"]
        @all_tumblr_posts = CacheTumblrPost.all.paginate :page => params[:page], :per_page => recent_posts_number
        @recent_tumblr_posts = CacheTumblrPost.order('post_date asc').limit(recent_posts_number)
      end
      if api_module.module_name == 'fleakr basic'
        # specific actions for fleakr basic
      end
      if api_module.module_name == 'vimeo basic'
        # specific actions for vimeo basic
      end
    end

    respond_to do |format|
      format.html { render 'show', :layout => page_template }
      format.xml  { render :xml => @page }
    end
  end
end
