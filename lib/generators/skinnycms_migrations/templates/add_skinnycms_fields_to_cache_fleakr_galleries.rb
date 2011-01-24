class AddSkinnycmsFieldsToCacheFleakrGalleries < ActiveRecord::Migration
  def self.up
    # add_column :cache_fleakr_galleries, :fleakr_gallery_id, :string
    # add_column :cache_fleakr_galleries, :title, :string
    # add_column :cache_fleakr_galleries, :description, :text
    # add_column :cache_fleakr_galleries, :incomplete, :boolean

    add_index :cache_fleakr_galleries, [:fleakr_gallery_id, :incomplete], :name => "index_fleakr_galleries_on_complete_id", :unique => true
  end

  def self.down
    # remove_column :cache_fleakr_galleries, :fleakr_gallery_id
    # remove_column :cache_fleakr_galleries, :title
    # remove_column :cache_fleakr_galleries, :description
    # remove_column :cache_fleakr_galleries, :incomplete

    remove_index "index_fleakr_galleries_on_complete_id"
  end
end