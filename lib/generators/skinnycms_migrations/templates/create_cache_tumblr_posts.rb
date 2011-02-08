class CreateCacheTumblrPosts < ActiveRecord::Migration
  def self.up
    create_table :cache_tumblr_posts do |t|
      t.string :tumblr_post_id
      t.string :title
      t.text :desc
      t.string :url
      t.string :reblog_key
      t.string :post_type
      t.datetime :post_date
      t.boolean :incomplete

      t.timestamps
    end
    
    add_index :cache_tumblr_posts, [:tumblr_post_id, :incomplete], :name => "index_tumblr_posts_on_complete_id", :unique => true
  end

  def self.down
    drop_table :cache_tumblr_posts
  end
end
