class PagesToNavigation < ActiveRecord::Base
  acts_as_tree :order => :position
  acts_as_list :scope => :parent_id

  belongs_to :navigation, :foreign_key => "nav_id"
  belongs_to :page
  
  validates_uniqueness_of :page_id, :scope => :nav_id

  def associated_page
    page.title
  end
  
  class << self
    def for_navigation(navigation_name)
      select("pages_to_navigations.*").
      joins("join navigations on pages_to_navigations.nav_id = navigations.id").
      where("navigations.title = '#{navigation_name}'")
    end
  end  
end