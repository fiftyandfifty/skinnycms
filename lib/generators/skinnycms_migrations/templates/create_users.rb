class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string :name
      t.database_authenticatable :null => false
      t.confirmable
      t.recoverable
      t.rememberable
      t.encryptable
      t.trackable

      t.timestamps
    end
    
    add_index :users, :email, :name => "index_users_on_email", :unique => true
    add_index :users, :confirmation_token, :name => "index_users_on_confirmation_token", :unique => true
    add_index :users, :reset_password_token, :name => "index_users_on_reset_password_token", :unique => true
  end

  def self.down
    drop_table :users
  end
end