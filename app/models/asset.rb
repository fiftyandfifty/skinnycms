class Asset < ActiveRecord::Base

  has_attached_file :asset,
                    :storage => :cloud_files,
                    :cloudfiles_credentials => Setting.rackspace_credentials,
                    :styles => { :medium => "300x300>", :small => "150x150>", :thumb => "40x40>", :bigthumb => "60x60>" }
                  
  BASIC_TYPES = ['all', 'text', 'image', 'audio', 'video']

  validates_attachment_presence :asset
  validates_attachment_size     :asset, :less_than => 50.megabytes

  before_asset_post_process :allow_only_images

  def allow_only_images
    if !(asset.content_type =~ %r{^(image|(x-)?application)/(x-png|pjpeg|jpeg|jpg|png|gif)$})
      return false
    end
  end

  def content_type
    BASIC_TYPES.each do |type|
      return type if asset_content_type.include?(type)
    end
  end

  class << self
    def types
     BASIC_TYPES
    end

    def image_list
      list = {}
      all.each { |element| list[element.title] = element.asset.url }
      list
    end
  end
end

