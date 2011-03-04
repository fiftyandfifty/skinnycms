class CacheFleakrGallery < ActiveRecord::Base

  def unique_id
    fleakr_gallery_id
  end
end