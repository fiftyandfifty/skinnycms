ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
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

  create_table :page_contents do |t|
    t.text     :content
    t.integer  :page_id
    t.string   :location
    t.integer  :order
    t.timestamps
  end
end

