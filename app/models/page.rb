class Page < ActiveRecord::Base
  cattr_accessor :parent_id
  cattr_accessor :visibility

  has_many :page_contents, :dependent => :destroy
  has_many :pages_to_navigations, :dependent => :destroy
  has_many :navigations, :through  => :pages_to_navigations
  belongs_to :template

  validates :title, :permalink, :presence => true
  
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true

  def parent_in_navigation(navigation_name)
    pages_to_navigations.find(:first, :conditions => { :nav_id => Navigation.find(:first, :conditions => { :title => navigation_name }).id }).parent_id
  end
  
  def parent_id_in_navigation(navigation_name)
    parent = parent_in_navigation(navigation_name)
    return {} if parent.blank? || parent == 0
    PagesToNavigation.find(parent).page.id
  end

  def parent_title_in_navigation(navigation_name)
    parent = parent_in_navigation(navigation_name)
    return "- No Parent - " if parent.blank? || parent == 0
    PagesToNavigation.find(parent).page.title
  end
  
  def this_navigation(navigation_name)
    this_nav = pages_to_navigations.first(:conditions => { :nav_id => Navigation.find(:first, :conditions => { :title => navigation_name }).id })
    this_nav = PagesToNavigation.new if this_nav.blank?
    return this_nav
  end

  def visibility_in_navigation(navigation_name)
    page_visibility = pages_to_navigations.find(:first, :conditions => { :nav_id => Navigation.find(:first, :conditions => { :title => navigation_name }).id }).visibility
    return "- No selected - " if page_visibility.blank?
    page_visibility
  end
end