class AddSkinnycmsFieldsToCacheTumblrPosts < ActiveRecord::Migration
  def self.up
    # add_column :cache_tumblr_posts, :tumblr_post_id, :string
    # add_column :cache_tumblr_posts, :title, :string
    # add_column :cache_tumblr_posts, :desc, :text
    # add_column :cache_tumblr_posts, :url, :string
    # add_column :cache_tumblr_posts, :reblog_key, :string
    # add_column :cache_tumblr_posts, :post_type, :string
    # add_column :cache_tumblr_posts, :post_date, :datetime
    # add_column :cache_tumblr_posts, :incomplete, :boolean

    # add_index :cache_tumblr_posts, [:tumblr_post_id, :incomplete], :name => "index_tumblr_posts_on_complete_id", :unique => true
  end

  def self.down
    # remove_column :cache_tumblr_posts, :tumblr_post_id
    # remove_column :cache_tumblr_posts, :title
    # remove_column :cache_tumblr_posts, :desc
    # remove_column :cache_tumblr_posts, :url
    # remove_column :cache_tumblr_posts, :reblog_key
    # remove_column :cache_tumblr_posts, :post_type
    # remove_column :cache_tumblr_posts, :post_date
    # remove_column :cache_tumblr_posts, :incomplete

    # remove_index "index_tumblr_posts_on_complete_id"
  end
end