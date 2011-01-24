class AddSkinnycmsFieldsToCustomModules < ActiveRecord::Migration
  def self.up
    # add_column :custom_modules, :title, :string
    # add_column :custom_modules, :header, :text
    # add_column :custom_modules, :content, :text
    # add_column :custom_modules, :sidebar, :text
  end

  def self.down
    # remove_column :custom_modules, :title
    # remove_column :custom_modules, :header
    # remove_column :custom_modules, :content
    # remove_column :custom_modules, :sidebar
  end
end