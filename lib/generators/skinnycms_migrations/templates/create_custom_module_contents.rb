class CreateCustomModuleContents < ActiveRecord::Migration
  def self.up
    create_table :custom_module_contents do |t|
      t.integer  :custom_module_id
      t.text     :content
      t.string   :location
      t.timestamps
    end
  end

  def self.down
    drop_table :custom_module_contents
  end
end

