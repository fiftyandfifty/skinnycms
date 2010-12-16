class Category < ActiveRecord::Base
  has_many :category_items
  has_many :categorizable, :through => :category_items

  validates :name, :presence => true
  validates :name, :uniqueness => { :case_sensitive => false }
end
