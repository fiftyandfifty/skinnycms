class PageContent < ActiveRecord::Base
  belongs_to :page

  validates :page_id, :location, :presence => true

  def module_title
    module_type.camelize.constantize.find(module_id).title
  end
end
