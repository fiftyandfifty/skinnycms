class Asset < ActiveRecord::Base
  has_attached_file :asset

  BASIC_TYPES = ['text', 'image', 'audio', 'video']

  def content_type
    BASIC_TYPES.each do |type|
      return type if asset_content_type.include?(type)
    end
  end
end
