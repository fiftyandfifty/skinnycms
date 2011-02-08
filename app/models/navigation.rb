class Navigation < ActiveRecord::Base
  has_many :pages_to_navigations, :foreign_key => "nav_id", :dependent => :destroy
  has_many :pages, :through  => :pages_to_navigations
end