class AddSkinnycmsFieldsToApiModules < ActiveRecord::Migration
  def self.up
    # add_column :api_modules, :title, :string
    # add_column :api_modules, :module_name, :string
    # add_column :api_modules, :module_version, :string
    # add_column :api_modules, :configuration, :text
  end

  def self.down
    # remove_column :api_modules, :title
    # remove_column :api_modules, :module_name
    # remove_column :api_modules, :module_version
    # remove_column :api_modules, :configuration
  end
end