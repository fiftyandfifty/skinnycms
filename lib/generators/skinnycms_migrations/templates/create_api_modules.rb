class CreateApiModules < ActiveRecord::Migration
  def self.up
    create_table :api_modules do |t|
      t.string   :title
      t.string   :module_name
      t.string   :module_version
      t.text     :configurations
  
      t.timestamps
    end
  end

  def self.down
    drop_table :api_modules
  end
end
