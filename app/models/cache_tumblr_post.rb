class CacheTumblrPost < ActiveRecord::Base
  has_many :category, :through => :category_items
  has_many :category_items, :as => :categorizable

  validates :title, :desc, :presence => true
end