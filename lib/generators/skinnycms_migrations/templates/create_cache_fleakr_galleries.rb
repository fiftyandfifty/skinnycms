class CreateCacheFleakrGalleries < ActiveRecord::Migration
  def self.up
    create_table :cache_fleakr_galleries do |t|
      t.string :fleakr_gallery_id
      t.string :title
      t.text :description
      t.boolean :incomplete

      t.timestamps
    end
    
    add_index :cache_fleakr_galleries, [:fleakr_gallery_id, :incomplete], :name => "index_fleakr_galleries_on_complete_id", :unique => true
  end

  def self.down
    drop_table :cache_fleakr_galleries

    remove_index "index_fleakr_galleries_on_complete_id"
  end
end
