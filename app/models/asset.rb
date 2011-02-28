class Asset < ActiveRecord::Base

  has_attached_file :asset,
                    :storage => :cloud_files,
                    :cloudfiles_credentials => "#{Rails.root}/config/rackspace_cloudfiles.yml",
                    :styles => {
                                :medium => "300x300>",
                                :small => "150x150>",
                                :thumb => "40x40>",
                                :bigthumb => "60x60>"
                               }

  before_asset_post_process :allow_only_images

  def allow_only_images
    if !(asset.content_type =~ %r{^(image|(x-)?application)/(x-png|pjpeg|jpeg|jpg|png|gif)$})
      return false
    end
  end
end
