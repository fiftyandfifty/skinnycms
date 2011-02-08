class PagesToNavigation < ActiveRecord::Base
  acts_as_tree :order => :position
  acts_as_list :scope => :parent_id

  belongs_to :navigation, :foreign_key => "nav_id"
  belongs_to :page

  def associated_page
    page.title
  end
end