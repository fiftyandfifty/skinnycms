class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  # devise :database_authenticatable, :timeoutable, :validatable, :timeout_in => 60.minutes #, :registerable
  devise :database_authenticatable, :encryptable, :timeoutable, :validatable, :timeout_in => 60.minutes, :encryptor => :sha1 #, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation
  
  # Validations
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :name, :email, :password, :password_confirmation, :presence => true
end
