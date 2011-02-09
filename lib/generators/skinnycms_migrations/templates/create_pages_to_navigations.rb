class CreatePagesToNavigations < ActiveRecord::Migration
  def self.up
    create_table :pages_to_navigations do |t|
      t.integer :nav_id
      t.integer :page_id
      t.integer :parent_id
      t.integer :position
      t.string :visibility
            
      t.timestamps
    end
  end

  def self.down
    drop_table :pages_to_navigations
  end
end
