class Admin::PostsController < ApplicationController  
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"
 
  def index
    @title = "Posts"
    login_and_get_tumblr_user
    @posts = CacheTumblrPost.find(:all, :conditions => "incomplete != 1")
  end

  def login_and_get_tumblr_user
    tumblr_module = ApiModule.where(:module_name => 'tumblr basic')
    api_token = tumblr_module.api_token
    api_key = tumblr_module.api_key
    user = Tumblr::User.new(api_token, api_key)
    info = HTTParty.get("http://www.tumblr.com/api/dashboard", :query => { :email => api_token, :password => api_key })
    Tumblr.blog = info["tumblr"]["posts"]["post"].first["tumblelog"]
    user
  end

  def update_cached_posts
    login_and_get_tumblr_user
    
    max_cache_length_in_minutes = 300
    tumblr_cache_sample = CacheTumblrPost.first(:conditions => "incomplete != 1")

    if tumblr_cache_sample.blank?
      cache_age_seconds = 10000000
    else
      cache_age_seconds = Time.now - tumblr_cache_sample.created_at.in_time_zone("Pacific Time (US & Canada)")
    end

    cache_age_minutes = cache_age_seconds / 60

    if cache_age_minutes > max_cache_length_in_minutes || tumblr_cache_sample.blank?
      # Select count of all posts
      all_posts_count = Tumblr::Request.read["tumblr"]["posts"]["total"].to_i

      # Define count of all 'read' requests to tumblr
      count_of_requests = all_posts_count/50 + 1

      # Define empty array of posts and step of requesting
      posts = []
      i = 0

      # Select all posts from tumblr
      count_of_requests.times do
        part_of_posts = Tumblr::Post.all(:query => { :start => 1 * i, :num => 50 }).uniq
        posts += part_of_posts
        i += 50
      end

      if posts.present?
         posts.each do |post|
           if post["type"] == "regular"
             new_data = {:tumblr_post_id => post["id"],
                        :title => post["regular_title"],
                        :desc => post["regular_body"],
                        :post_date => post["date"],
                        :url => post["url_with_slug"],
                        :reblog_key => post["reblog_key"],
                        :post_type => post["type"],
                        :incomplete => 1 }
             CacheTumblrPost.create(new_data)
           end
        end
        CacheTumblrPost.delete_all(:incomplete => false)
        CacheTumblrPost.update_all(:incomplete => false)
      end
    end
  end

  def define_page
    @current_page = 'modules'
  end
end