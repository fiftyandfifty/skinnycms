class AddSkinnycmsFieldsToCacheVimeoVideos < ActiveRecord::Migration
  def self.up
    # add_column :cache_vimeo_videos, :vimeo_video_id, :string
    # add_column :cache_vimeo_videos, :title, :string
    # add_column :cache_vimeo_videos, :description, :text
    # add_column :cache_vimeo_videos, :url, :string
    # add_column :cache_vimeo_videos, :upload_date, :datetime
    # add_column :cache_vimeo_videos, :incomplete, :boolean

    add_index :cache_vimeo_videos, [:vimeo_video_id, :incomplete], :name => "index_vimeo_videos_on_complete_id", :unique => true
  end

  def self.down
    # remove_column :cache_vimeo_videos, :vimeo_video_id
    # remove_column :cache_vimeo_videos, :title
    # remove_column :cache_vimeo_videos, :description
    # remove_column :cache_vimeo_videos, :url
    # remove_column :cache_vimeo_videos, :upload_date
    # remove_column :cache_vimeo_videos, :incomplete

    remove_index "index_vimeo_videos_on_complete_id"
  end
end