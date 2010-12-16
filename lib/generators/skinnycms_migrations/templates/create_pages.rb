class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.text :header
      t.string :permalink
      t.integer :parent_id
      t.integer :template_id
      t.string :status
      t.string :visibility
      t.string :sidebar
      t.integer :position
      t.string :redirect_url
      t.string :seo_title
      t.text :seo_description
      t.string :seo_keywords
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
