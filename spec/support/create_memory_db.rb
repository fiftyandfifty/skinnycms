ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.string   :email, :default => "", :null => false
    t.string   :encrypted_password, :limit => 128, :default => "", :null => false
    t.string   :password_salt, :default => "", :null => false
    t.string   :confirmation_token
    t.datetime :confirmed_at
    t.datetime :confirmation_sent_at
    t.string   :reset_password_token
    t.string   :remember_token
    t.datetime :remember_created_at
    t.integer  :sign_in_count, :default => 0
    t.datetime :current_sign_in_at
    t.datetime :last_sign_in_at
    t.string   :current_sign_in_ip
    t.string   :last_sign_in_ip
    t.datetime :created_at
    t.datetime :updated_at
    t.string   :name
  end

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

