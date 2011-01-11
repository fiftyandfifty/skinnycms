class PagesController < ApplicationController

  layout 'front_end'
  
  def index    
    @page = Page.first
    @page_content = PageContent.find(:first, :conditions => ["page_id = ?", @page.id])
  end
end
