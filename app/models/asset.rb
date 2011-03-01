class Asset < ActiveRecord::Base

  after_update :reprocess

  has_attached_file :asset, :styles         => lambda { |a|
                                                 if a.instance.thumbnailable?
                                                   {:medium => "300x300>", :small => "150x150>", :thumb => "40x40>", :bigthumb => "60x60>"}
                                                 elsif a.instance.editable?
                                                   {:original => {:contents => 'asset_contents'}}
                                                 end
                                               },
                                               #:storage => :cloud_files,
                                               #:cloudfiles_credentials => Setting.rackspace_credentials,
                            :processors     => lambda { |a|
                                                 if a.editable?
                                                   [:file_contents]
                                                 elsif a.thumbnailable?
                                                   [:thumbnail]
                                                 end
                                               }

  attr_protected :asset_file_name, :asset_content_type, :asset_size

  validates_attachment_size     :asset, :less_than => 6.megabytes
  validates_attachment_presence :asset

  BASIC_TYPES = ['text', 'image', 'audio', 'video']

  def editable?
    return false unless asset.content_type
    ['text/css', 'application/js', 'text/plain', 'text/x-json', 'application/json', 'application/javascript',
     'application/x-javascript', 'text/javascript', 'text/x-javascript', 'text/x-json',
     'text/html', 'application/xhtml', 'application/xml', 'text/xml', 'text/js'].join('').include?(asset.content_type)
  end

  def thumbnailable?
    return false unless asset.content_type
    ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg'].join('').include?(asset.content_type)
  end

  def content_type
    BASIC_TYPES.each do |type|
      return type if asset_content_type.include?(type)
    end
  end

  private
  
  def reprocess
    asset.reprocess! if editable?
  end 
end
