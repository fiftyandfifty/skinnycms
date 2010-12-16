class CreateCategoryItems < ActiveRecord::Migration
  def self.up
    create_table :category_items do |t|
      t.integer :category_id
      t.references :categorizable, :polymorphic => true
      
      t.timestamps
    end
  end

  def self.down
    drop_table :category_items
  end
end
