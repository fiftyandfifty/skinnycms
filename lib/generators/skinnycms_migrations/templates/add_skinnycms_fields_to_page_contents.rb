class AddSkinnycmsFieldsToPageContents < ActiveRecord::Migration
  def self.up
    # add_column :page_contents, :page_id, :integer
    # add_column :page_contents, :content, :text
    # add_column :page_contents, :position, :integer
    # add_column :page_contents, :location, :string
    # add_column :page_contents, :module_type, :string
    # add_column :page_contents, :module_id, :integer
  end

  def self.down
    # remove_column :page_contents, :page_id
    # remove_column :page_contents, :content
    # remove_column :page_contents, :position
    # remove_column :page_contents, :location
    # remove_column :page_contents, :module_type
    # remove_column :page_contents, :module_id
  end
end