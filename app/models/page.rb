class Page < ActiveRecord::Base
  cattr_accessor :parent_id
  cattr_accessor :navigation

  has_many :page_contents, :dependent => :destroy
  has_many :pages_to_navigations, :dependent => :destroy
  has_many :navigations, :through  => :pages_to_navigations
  belongs_to :template

  validates :title, :permalink, :presence => true
  
  has_friendly_id :title_or_permalink, :use_slug => true, :approximate_ascii => true
  
  scope :not_on_nav, :conditions => 'pages_to_navigations.navigation_id IS NULL' , :order => :title, :include => :pages_to_navigations  

  def title_or_permalink
    if !permalink.blank?
      permalink
    else
      title
    end 
  end

  def parent_in_navigation(navigation_name)
    pages_to_navigations.find(:first, :conditions => { :navigation_id => Navigation.find(:first, :conditions => { :title => navigation_name }).id }).parent_id rescue 0
    # TODO: fix the rescue above
  end
  
  def parent_id_in_navigation(navigation_name)
    parent = parent_in_navigation(navigation_name)
    return {} if parent.blank? || parent == 0
    PagesToNavigation.find(parent).page.id
  end

  def parent_title_in_navigation(navigation_name)
    parent = parent_in_navigation(navigation_name)
    return "Not on #{navigation_name}" if parent.blank? || parent == 0
    PagesToNavigation.find(parent).page.title
  end
  
  def this_navigation(navigation_name)
    this_nav = pages_to_navigations.first(:conditions => { :navigation_id => Navigation.find(:first, :conditions => { :title => navigation_name }).id })
    this_nav = PagesToNavigation.new if this_nav.blank?
    return this_nav
  end

  def exist_in_navigation?(navigation_name)
    navigations.where(:title => navigation_name).present?
  end
end