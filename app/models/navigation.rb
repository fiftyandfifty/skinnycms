class Navigation < ActiveRecord::Base
  has_many :pages_to_navigations, :dependent => :destroy
  has_many :pages, :through  => :pages_to_navigations
  
  validates_uniqueness_of :title
end