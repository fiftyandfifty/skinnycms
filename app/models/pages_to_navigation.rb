class PagesToNavigation < ActiveRecord::Base
  acts_as_tree :order => :position
  acts_as_list :scope => :parent_id

  belongs_to :navigation
  belongs_to :page
  
  validates_uniqueness_of :page_id, :scope => :navigation_id

  scope :public_and_redirect_in_root, lambda { |navigation| { :conditions => { :parent_id => 0, :navigation_id => navigation }, :order => :position } }
  scope :private_in_root, :conditions => { :parent_id => 0, :navigation_id => nil }, :order => :position

  def associated_page
    page.title
  end
  
  class << self
    def for_navigation(navigation_name)
      pages_to_navigations = select("pages_to_navigations.*").
      joins("join navigations on pages_to_navigations.navigation_id = navigations.id").
      where("navigations.title = '#{navigation_name}'")
      return pages_to_navigations if pages_to_navigations.present?
      []
    end
    
    def for_navigation_roots(navigation_name)
      pages_to_navigations = select("pages_to_navigations.*").
      joins("join navigations on pages_to_navigations.navigation_id = navigations.id").
      where("navigations.title = '#{navigation_name}' AND (pages_to_navigations.parent_id IS NULL OR pages_to_navigations.parent_id < 1)")
      return pages_to_navigations if pages_to_navigations.present?
      []
    end

    def public_and_redirect_in_root_for(navigation_name)
      public_and_redirect_in_root(Navigation.where(:title => navigation_name))
    end

    def for_navigation_without_dublicates(navigation_name, page)
      page_parent_id = page.parent_in_navigation(navigation_name)
      page_parent = find(page_parent_id) if page_parent_id > 0
      pages_to_navigations = for_navigation(navigation_name)
      pages_to_navigations.delete_if { |p| p.page.id == page_parent.page.id } unless page_parent.nil?
      pages_to_navigations.delete_if { |p| p.page.id == page.id }
    end
  end  
end