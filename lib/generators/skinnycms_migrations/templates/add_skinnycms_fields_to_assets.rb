class AddSkinnycmsFieldsToAssets < ActiveRecord::Migration
  def self.up
    # add_column :assets, :title, :string
    # add_column :assets, :description, :text
    # add_column :assets, :asset_file_name, :string
    # add_column :assets, :asset_content_type, :string
    # add_column :assets, :asset_file_size, :integer
    # add_column :assets, :asset_updated_at, :datetime
  end

  def self.down
    # remove_column :assets, :title
    # remove_column :assets, :description
    # remove_column :assets, :asset_file_name
    # remove_column :assets, :asset_content_type
    # remove_column :assets, :asset_file_size
    # remove_column :assets, :asset_updated_at
  end
end