class PageContent < ActiveRecord::Base
  belongs_to :page

  validates :page_id, :location, :presence => true
end
