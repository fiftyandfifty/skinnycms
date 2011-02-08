class CreateNavigations < ActiveRecord::Migration
  def self.up
    create_table :navigations do |t|
      t.string :title
            
      t.timestamps
    end
  end

  def self.down
    drop_table :navigations
  end
end
