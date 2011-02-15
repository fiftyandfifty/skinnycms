class AddSkinnycmsFieldsToTemplates < ActiveRecord::Migration
  def self.up
    # add_column :templates, :title, :string
    # add_column :templates, :content_locations, :string
  end

  def self.down
    # remove_column :templates, :title
    # remove_column :templates, :content_locations
  end
end