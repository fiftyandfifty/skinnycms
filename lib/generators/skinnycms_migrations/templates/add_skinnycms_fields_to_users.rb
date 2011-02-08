class AddSkinnycmsFieldsToUsers < ActiveRecord::Migration
  def self.up
    # add_column :users, :email, :string
    # add_column :users, :encrypted_password, :string
    # add_column :users, :password_salt, :string
    # add_column :users, :confirmation_token, :string
    # add_column :users, :remember_token, :string
    # add_column :users, :reset_password_token, :string
    # add_column :users, :password_salt, :string
    # add_column :users, :current_sign_in_ip, :string
    # add_column :users, :last_sign_in_ip, :string
    # add_column :users, :sign_in_count, :integer
    # add_column :users, :remember_created_at, :datetime
    # add_column :users, :current_sign_in_at, :datetime
    # add_column :users, :last_sign_in_at, :datetime
    # add_column :users, :confirmed_at, :datetime
    # add_column :users, :confirmation_sent_at, :datetime
    
    # add_index :users, :email, :name => "index_users_on_email", :unique => true
    # add_index :users, :confirmation_token, :name => "index_users_on_confirmation_token", :unique => true
    # add_index :users, :reset_password_token, :name => "index_users_on_reset_password_token", :unique => true
  end

  def self.down
    # remove_index "index_users_on_email"
    # remove_index "index_users_on_confirmation_token"
    # remove_index "index_users_on_reset_password_token"

    # remove_column :users, :email
    # remove_column :users, :encrypted_password
    # remove_column :users, :password_salt
    # remove_column :users, :confirmation_token
    # remove_column :users, :remember_token
    # remove_column :users, :reset_password_token
    # remove_column :users, :password_salt
    # remove_column :users, :current_sign_in_ip
    # remove_column :users, :last_sign_in_ip
    # remove_column :users, :sign_in_count
    # remove_column :users, :remember_created_at
    # remove_column :users, :current_sign_in_at
    # remove_column :users, :last_sign_in_at
    # remove_column :users, :confirmed_at
    # remove_column :users, :confirmation_sent_at
  end
end