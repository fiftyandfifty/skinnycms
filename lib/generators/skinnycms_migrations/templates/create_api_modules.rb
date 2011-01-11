class CreateApiModules < ActiveRecord::Migration
  def self.up
    create_table :api_modules do |t|
      t.string   :module_name
      t.string   :module_version
      t.string   :title
      t.string   :api_user
      t.string   :api_password
      t.string   :api_token
      t.string   :api_key
      t.timestamps
    end
  end

  def self.down
    drop_table :api_modules
  end
end
