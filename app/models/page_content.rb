class PageContent < ActiveRecord::Base
  belongs_to :page

  cattr_accessor :header, :sidebar

  validates :page_id, :location, :presence => true
end
