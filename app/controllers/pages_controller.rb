class PagesController < ApplicationController

  layout 'front_end'
  
  def index    
    @page = Page.first
    @page_content = PageContent.find(:first, :conditions => ["page_id = ?", @page.id])
  end
  
  def show
    @page = Page.find(params[:id])
    @page_content = PageContent.find(:first, :conditions => ["page_id = ?", @page.id])

    if @page.visibility == "redirect"
      redirect_to @page.redirect_url
      return
    end
    
  end
  
end
