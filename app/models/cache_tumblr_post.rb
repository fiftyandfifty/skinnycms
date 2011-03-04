class CacheTumblrPost < ActiveRecord::Base

  validates :title, :desc, :presence => true

  def unique_id
    tumblr_post_id
  end
end