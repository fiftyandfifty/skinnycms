class Page < ActiveRecord::Base
  cattr_accessor :parent_id

  has_many :page_contents, :dependent => :destroy
  has_many :pages_to_navigations, :dependent => :destroy
  has_many :navigations, :through  => :pages_to_navigations
  belongs_to :template

  validates :title, :permalink, :presence => true
  
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true

  scope :public_and_redirect_pages, :conditions => { :visibility => ['public', 'redirect'] }
  scope :private_pages, :conditions => { :visibility => 'private' }
  
  def parent_in_navigation(navigation_name)
    parent = pages_to_navigations.find(:first, :conditions => { :nav_id => Navigation.find(:first, :conditions => { :title => navigation_name }).id }).parent_id
    return "- No Parent - " if parent.blank? || parent == 0
    PagesToNavigation.find(parent).page.title
  end
  
  def this_navigation(navigation_name)
    this_nav = pages_to_navigations.first(:conditions => { :nav_id => Navigation.find(:first, :conditions => { :title => navigation_name }).id })
    this_nav = PagesToNavigation.new if this_nav.blank?
    return this_nav
  end

  class << self
    def public_and_redirect_in_root

    end

    def private_in_root

    end
  end
end