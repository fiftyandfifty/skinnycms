class PageContent < ActiveRecord::Base
  belongs_to :page

  validates :page_id, :location, :presence => true

  CONTENT_TYPES = { 'CustomModule' => 'id',
                    'ApiModule' => 'id',
                    'CacheTumblrPost' => 'tumblr_post_id',
                    'CacheFleakrGallery' => 'fleakr_gallery_id',
                    'CacheVimeoVideo' => 'vimeo_video_id' }

  def remote_module
    module_type.camelize.constantize.where(CONTENT_TYPES[module_type] => module_id).first
  end

  def content_for_location(location)
    remote_module.send(location)
  end
end
