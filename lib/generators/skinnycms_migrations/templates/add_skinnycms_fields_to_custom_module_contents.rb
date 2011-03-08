class AddSkinnycmsFieldsToCustomModuleContents < ActiveRecord::Migration
  def self.up
    # add_column :custom_module_contents, :custom_module_id, :integer
    # add_column :custom_module_contents, :content, :text
    # add_column :custom_module_contents, :location, :string
  end

  def self.down
    # remove_column :custom_module_contents, :custom_module_id
    # remove_column :custom_module_contents, :content
    # remove_column :custom_module_contents, :location
  end
end

