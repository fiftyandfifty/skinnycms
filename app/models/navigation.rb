class Navigation < ActiveRecord::Base
  has_many :pages_to_navigations, :dependent => :destroy
end