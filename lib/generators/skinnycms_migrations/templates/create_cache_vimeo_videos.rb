class CreateCacheVimeoVideos < ActiveRecord::Migration
  def self.up
    create_table :cache_vimeo_videos do |t|
      t.string :vimeo_video_id
      t.string :title
      t.text :description
      t.string :url
      t.datetime :upload_date
      t.boolean :incomplete

      t.timestamps
    end
    
    add_index :cache_vimeo_videos, [:vimeo_video_id, :incomplete], :name => "index_vimeo_videos_on_complete_id", :unique => true
  end

  def self.down
    drop_table :cache_vimeo_videos
  end
end
