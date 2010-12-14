class CreatePageContentsTable < ActiveRecord::Migration
  def self.up
    create_table :page_contents do |t|
      t.text     :content
      t.integer  :page_id
      t.string   :location
      t.integer  :order
      t.timestamps
    end
  end

  def self.down
    drop_table :page_contents
  end
end
