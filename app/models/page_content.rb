class PageContent < ActiveRecord::Base
  belongs_to :page
  belongs_to :custom_modules, :primary_key => :module_id

  validates :page_id, :location, :presence => true
  
  validates_uniqueness_of :content, :scope => [:page_id, :position, :location, :module_type, :module_id]

  CONTENT_TYPES = { 'CustomModule' => 'id',
                    'ApiModule' => 'id',
                    'CacheTumblrPost' => 'tumblr_post_id',
                    'CacheFleakrGallery' => 'fleakr_gallery_id',
                    'CacheVimeoVideo' => 'vimeo_video_id' }

  def remote_module
    module_type.camelize.constantize.where(CONTENT_TYPES[module_type] => module_id).first
  end

  def content_for_location(location)
    content_module = remote_module.custom_module_contents.where(:location => location).first
    content = content_module.present? ? content_module.content : ''
  end
end

