class CacheVimeoVideo < ActiveRecord::Base

  def unique_id
    vimeo_video_id
  end
end