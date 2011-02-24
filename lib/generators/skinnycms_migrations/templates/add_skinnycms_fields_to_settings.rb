class AddSkinnycmsFieldsToSettings < ActiveRecord::Migration
  def self.up
    # add_column :settings, :title, :string
    # add_column :settings, :setting_type, :string
    # add_column :settings, :configuration, :text
  end

  def self.down
    # remove_column :settings, :title
    # remove_column :settings, :setting_type
    # remove_column :settings, :configuration
  end
end