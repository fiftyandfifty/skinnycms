class Admin::VideosController < ApplicationController  
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"
 
  def index
    @title = "Videos"
    login_and_get_vimeo_user
    @videos = CacheVimeoVideo.find(:all, :conditions => "incomplete != 1")
  end

  def login_and_get_vimeo_user
    ApiModule.where(:module_name => 'vimeo basic').api_token
  end

  def update_cached_videos   
    max_cache_length_in_minutes = 300
    vimeo_cache_sample = CacheVimeoVideo.first(:conditions => "incomplete != 1")

    if vimeo_cache_sample.blank?
      cache_age_seconds = 10000000
    else
      cache_age_seconds = Time.now - vimeo_cache_sample.created_at.in_time_zone("Pacific Time (US & Canada)")
    end

    cache_age_minutes = cache_age_seconds / 60

    if cache_age_minutes > max_cache_length_in_minutes || vimeo_cache_sample.blank?

      videos = Vimeo::Simple::User.all_videos(login_and_get_vimeo_user) rescue {}
      if videos.present?
         videos.each do |video|
             new_data = {:vimeo_video_id => video["id"],
                        :title => video["title"],
                        :description => video["description"],
                        :url => video["url"],
                        :upload_date => video["upload_date"],
                        :incomplete => 1 }
             CacheVimeoVideo.create(new_data)
        end
        CacheVimeoVideo.delete_all(:incomplete => false)
        CacheVimeoVideo.update_all(:incomplete => false)
      end
    end
  end

  def define_page
    @current_page = 'videos'
  end
end