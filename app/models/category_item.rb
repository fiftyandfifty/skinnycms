class CategoryItem < ActiveRecord::Base
  belongs_to :categorizable, :polymorphic => true
  belongs_to :category
  belongs_to :cache_tumblr_post, :class_name => "CacheTumblrPost", :foreign_key => "tumblr_post_id"

  validates :category_id, :categorizable_type, :categorizable_id, :presence => true
end
