class Page < ActiveRecord::Base
  acts_as_tree :order => :position
  acts_as_list :scope => :parent_id

  has_many :page_contents, :dependent => :destroy

  validates :title, :permalink, :presence => true
  
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true

  scope :public_and_redirect_in_root, :conditions => { :visibility => ['public', 'redirect'], :parent_id => nil }, :order => :position
  scope :private_in_root, :conditions => { :visibility => 'private', :parent_id => nil }, :order => :position
end