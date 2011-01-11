class CreateCustomModules < ActiveRecord::Migration
  def self.up
    create_table :custom_modules do |t|
      t.string   :title
      t.text     :header
      t.text     :content
      t.text     :sidebar
      t.timestamps
    end
  end

  def self.down
    drop_table :custom_modules
  end
end
