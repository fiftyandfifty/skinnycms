class Admin::PostsController < ApplicationController  
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"
 
  def index
    @title = "Posts"
    login_and_get_tumblr_user
    @posts = CacheTumblrPost.find(:all, :conditions => "incomplete != 1")
  end
  
  def show
    
  end
  
  def edit
    login_and_get_tumblr_user
    @post = CacheTumblrPost.find(params[:id])
    @category_item = CategoryItem.find_by_categorizable_id(@post.tumblr_post_id, :conditions => "categorizable_type = 'CacheTumblrPost'")
  end
  
  def update
    user = login_and_get_tumblr_user
    post = CacheTumblrPost.find_by_tumblr_post_id(params[:id])
    tumblr_post = Tumblr::Post.create(user, :post_id => post.tumblr_post_id, :title => params[:post][:title], :body => params[:post][:content])

    if tumblr_post
      category_item = CategoryItem.find_by_categorizable_id(post.tumblr_post_id, :conditions => "categorizable_type = 'CacheTumblrPost'")
      if category_item
        category_item.update_attribute(:category_id, params[:category][:id])
      else
        CategoryItem.create(:categorizable_id => post.tumblr_post_id, :categorizable_type => "CacheTumblrPost", :category_id => params[:category][:id])
      end
      flash[:notice] = 'Post successfully updated!'
      force_reload
    else
      flash[:error] = 'There was an error updating your post on Tumblr'
      redirect_to(edit_admin_post_url(params[:local_id]))
    end
  end
  
  def new
    
  end
  
  def create
    user = login_and_get_tumblr_user
    unless params[:post][:title].blank? || params[:post][:content].blank?
      tumblr_post = Tumblr::Post.create(user, :type => 'regular', :title => params[:post][:title], :body => params[:post][:content])

      if tumblr_post
        tumblr_post_id = Tumblr::Post.all.first["id"]
        CategoryItem.create(:categorizable_id => tumblr_post_id, :categorizable_type => "CacheTumblrPost", :category_id => params[:category][:id])
      #  FeaturedPost.create(:post_id => tumblr_post.id, :image_url => params[:featured_post][:image_url]) if params[:featured_post][:featured] == "yes"
        flash[:notice] = 'Post successfully created!'
        force_reload
      else
        flash[:error] = 'There was an error creating your post on Tumblr'
        redirect_to(new_admin_post_url)
      end
    else
      flash[:error] = 'There was an error: post cannot be empty!'
      redirect_to(new_admin_post_url)
    end
  end
  
  def destroy
    user = login_and_get_tumblr_user
    post = CacheTumblrPost.find(params[:id])
    tumblr_post = Tumblr::Post.destroy(user, :post_id => post.tumblr_post_id)

    if tumblr_post
      category_item = CategoryItem.find_by_categorizable_id(post.tumblr_post_id, :conditions => "categorizable_type = 'CacheTumblrPost'")
      category_item.delete if category_item
      post.delete
      flash[:notice] = 'Post successfully deleted!'
      force_reload
    else
      flash[:error] = 'There was an error deleting your post from Tumblr!'
      redirect_to(admin_posts_url)
    end
  end

  def login_and_get_tumblr_user
    user = Tumblr::User.new('ruslan.hamidullin@flatsoft.com', 'alkapone')
    Tumblr.blog = 'ruslanka'
    user
  end

  def force_reload
    update_cached_posts
    redirect_to(admin_posts_url)
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
      posts = Tumblr::Post.all rescue {}
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