class Admin::GalleriesController < ApplicationController  
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"
 
  def index
    @title = "Galleries"
    login_and_get_fleakr_user
    @galleries = CacheFleakrGallery.find(:all, :conditions => "incomplete != 1")
  end

  def login_and_get_fleakr_user
    fleakr_module = ApiModule.where(:module_name => 'fleakr basic')
    Fleakr.api_key = fleakr_module.api_key
    Fleakr.user(fleakr_module.api_token)
  end

  def update_cached_galleries
    
    max_cache_length_in_minutes = 300
    fleakr_cache_sample = CacheFleakrGallery.first(:conditions => "incomplete != 1")

    if fleakr_cache_sample.blank?
      cache_age_seconds = 10000000
    else
      cache_age_seconds = Time.now - fleakr_cache_sample.created_at.in_time_zone("Pacific Time (US & Canada)")
    end

    cache_age_minutes = cache_age_seconds / 60

    if cache_age_minutes > max_cache_length_in_minutes || fleakr_cache_sample.blank?

      galleries = login_and_get_fleakr_user.sets rescue {}
      if galleries.present?
         galleries.each do |gallery|
             new_data = {:fleakr_gallery_id => gallery.id,
                        :title => gallery.title,
                        :description => gallery.description,
                        :incomplete => 1 }
             CacheFleakrGallery.create(new_data)
        end
        CacheFleakrGallery.delete_all(:incomplete => false)
        CacheFleakrGallery.update_all(:incomplete => false)
      end
    end
  end

  def define_page
    @current_page = 'galleries'
  end
end