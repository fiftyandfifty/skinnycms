class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.string :permalink
      t.string :status
      t.string :redirect_url
      t.string :seo_title
      t.text :seo_description
      t.string :seo_keywords
      t.integer :template_id
            
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
