class Admin::DashboardController < ApplicationController
  before_filter :authenticate_user!
  layout "front_end"
  
  def index
    @title = "Dashboard"
    
    @pages = Page.all
    #@images = Image.all
    #@posts = CacheTumblrPost.all(:conditions => "incomplete != 1")
        
    #tumblr_user = login_and_get_tumblr_user('theresolve')
    #@tumblr_blog_name = tumblr_user.tumblr['tumblelog']['name'] rescue false
  end
end
