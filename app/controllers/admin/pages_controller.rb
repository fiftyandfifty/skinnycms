class Admin::PagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"
  uses_tiny_mce
  respond_to :html, :xml

  def index
    @title = "Pages"

    @pages = Page.public_and_redirect_in_root
    @private_pages = Page.private_in_root

    respond_to do |format|
      format.html
      format.xml  { render :xml => @pages }
    end
  end

  def show
    @page = Page.find(params[:id]) rescue nil

    respond_to do |format|
      format.html
      format.xml  { render :xml => @page }
    end
  end

  def new
    @title = "Add Page"
    @page = Page.new
    @page_content = PageContent.new
    
    available_modules = CustomModule.all + CacheTumblrPost.all + CacheVimeoVideo.all + CacheFleakrGallery.all
    @available_modules = available_modules.paginate :page => params[:page], :per_page => 10

    respond_to do |format|
      format.html
      format.xml { render :xml => @page }
    end
  end

  def edit
    @title = "Edit Page"
    @page = Page.find(params[:id])

    @header_contents = PageContent.where(:page_id => @page, :location => 'header')
    @page_contents = PageContent.where(:page_id => @page, :location => 'content')
    @sidebar_contents = PageContent.where(:page_id => @page, :location => 'sidebar')

    available_modules = CustomModule.all + CacheTumblrPost.all + CacheVimeoVideo.all + CacheFleakrGallery.all
    @available_modules = available_modules.paginate :page => params[:page], :per_page => 10
  end

  def create
    Rails.logger.info "++++++++++++++++++ #{params.inspect}"
    @page = Page.new(params[:page])

    if @page.save
      if params[:header_new].present?

        all_headers_content = params[:header_new]
        headers_custom_modules = params[:header_new]["CustomModule"] if params[:header_new]["CustomModule"].present?
        headers_tumblr_posts = params[:header_new]["CacheTumblrPost"] if params[:header_new]["CacheTumblrPost"].present?
        headers_vimeo_videos = params[:header_new]["CacheVimeoVideo"] if params[:header_new]["CacheVimeoVideo"].present?
        headers_fleakr_galleries = params[:header_new]["CacheFleakrGallery"] if params[:header_new]["CacheFleakrGallery"].present?
        headers_unique_modules = params[:header_new].delete_if { |key,value| key=="CustomModule" || key=="CacheTumblrPost" || key=="CacheVimeoVideo" || key=="CacheFleakrGallery" }

        if headers_unique_modules
          headers_unique_modules.each do |key, value|
            PageContent.create(:content => value,
                               :page_id => @page.id,
                               :location => "header")
          end
        end

        if headers_custom_modules
          headers_custom_modules.each do |key, value|
            PageContent.create(:content => CustomModule.find(value).header,
                               :module_type => 'CustomModule',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "header")
          end
        end

        if headers_tumblr_posts
          headers_tumblr_posts.each do |key, value|
            PageContent.create(:content => CacheTumblrPost.find(:first, :conditions => { :tumblr_post_id => value }).desc,
                               :module_type => 'CacheTumblrPost',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "header")
          end
        end

        if headers_vimeo_videos
          headers_vimeo_videos.each do |key, value|
            PageContent.create(:content => CacheVimeoVideo.find(:first, :conditions => { :vimeo_video_id => value }).url,
                               :module_type => 'CacheVimeoVideo',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "header")
          end
        end

        if headers_fleakr_galleries
          headers_fleakr_galleries.each do |key, value|
            PageContent.create(:content => CacheFleakrGallery.find(:first, :conditions => { :fleakr_gallery_id => value }).title,
                                                                   :module_type => 'CacheFleakrGallery',
                                                                   :module_id => value,
                                                                   :page_id => @page.id,
                                                                   :location => "header")
          end
        end
      end

      if params[:content_new].present?

        all_pages_content = params[:content_new]
        pages_custom_modules = params[:content_new]["CustomModule"] if params[:content_new]["CustomModule"].present?
        pages_tumblr_posts = params[:content_new]["CacheTumblrPost"] if params[:content_new]["CacheTumblrPost"].present?
        pages_vimeo_videos = params[:content_new]["CacheVimeoVideo"] if params[:content_new]["CacheVimeoVideo"].present?
        pages_fleakr_galleries = params[:content_new]["CacheFleakrGallery"] if params[:content_new]["CacheFleakrGallery"].present?
        pages_unique_modules = params[:content_new].delete_if { |key,value| key=="CustomModule" || key=="CacheTumblrPost" || key=="CacheVimeoVideo" || key=="CacheFleakrGallery" }

        if headers_unique_modules
          cleaned_values = []
          headers_unique_modules.each do |key, value|
            if value.include?("<p>&nbsp;</p>\r\n")
              cleaned_value = value.gsub!("<p>&nbsp;</p>\r\n","")
            else
              cleaned_value = value
            end
            cleaned_values << cleaned_value
          end
          cleaned_values.each { |value| PageContent.create(:content => value, :page_id => @page.id, :location => "content") }
        end 

        if pages_custom_modules
          pages_custom_modules.each do |key, value|
            PageContent.create(:content => CustomModule.find(value).content,
                               :module_type => 'CustomModule',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "content")
          end
        end

        if pages_tumblr_posts
          pages_tumblr_posts.each do |key, value|
            PageContent.create(:content => CacheTumblrPost.find(:first, :conditions => { :tumblr_post_id => value }).desc,
                               :module_type => 'CacheTumblrPost',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "content")
          end
        end

        if pages_vimeo_videos
          pages_vimeo_videos.each do |key, value|
            PageContent.create(:content => CacheVimeoVideo.find(:first, :conditions => { :vimeo_video_id => value }).url,
                               :module_type => 'CacheVimeoVideo',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "content")
          end
        end

        if pages_fleakr_galleries
          pages_fleakr_galleries.each do |key, value|
            PageContent.create(:content => CacheFleakrGallery.find(:first, :conditions => { :fleakr_gallery_id => value }).title,
                                                                   :module_type => 'CacheFleakrGallery',
                                                                   :module_id => value,
                                                                   :page_id => @page.id,
                                                                   :location => "content")
          end
        end
      end

      if params[:sidebar_new].present?

        all_sidebars_content = params[:sidebar_new]
        sidebars_custom_modules = params[:sidebar_new]["CustomModule"] if params[:sidebar_new]["CustomModule"].present?
        sidebars_tumblr_posts = params[:sidebar_new]["CacheTumblrPost"] if params[:sidebar_new]["CacheTumblrPost"].present?
        sidebars_vimeo_videos = params[:sidebar_new]["CacheVimeoVideo"] if params[:sidebar_new]["CacheVimeoVideo"].present?
        sidebars_fleakr_galleries = params[:sidebar_new]["CacheFleakrGallery"] if params[:sidebar_new]["CacheFleakrGallery"].present?
        sidebars_unique_modules = params[:sidebar_new].delete_if { |key,value| key=="CustomModule" || key=="CacheTumblrPost" || key=="CacheVimeoVideo" || key=="CacheFleakrGallery" }

        if sidebars_unique_modules
          sidebars_unique_modules.each do |key, value|
            PageContent.create(:content => value,
                               :page_id => @page.id,
                               :location => "sidebar")
          end
        end

        if sidebars_custom_modules
          sidebars_custom_modules.each do |key, value|
            PageContent.create(:content => CustomModule.find(value).sidebar,
                               :module_type => 'CustomModule',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "sidebar")
          end
        end

        if sidebars_tumblr_posts
          sidebars_tumblr_posts.each do |key, value|
            PageContent.create(:content => CacheTumblrPost.find(:first, :conditions => { :tumblr_post_id => value }).desc,
                               :module_type => 'CacheTumblrPost',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "sidebar")
          end
        end

        if sidebars_vimeo_videos
          sidebars_vimeo_videos.each do |key, value|
            PageContent.create(:content => CacheVimeoVideo.find(:first, :conditions => { :vimeo_video_id => value }).url,
                               :module_type => 'CacheVimeoVideo',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "sidebar")
          end
        end

        if sidebars_fleakr_galleries
          sidebars_fleakr_galleries.each do |key, value|
            PageContent.create(:content => CacheFleakrGallery.find(:first, :conditions => { :fleakr_gallery_id => value }).title,
                                                                   :module_type => 'CacheFleakrGallery',
                                                                   :module_id => value,
                                                                   :page_id => @page.id,
                                                                   :location => "sidebar")
          end
        end
      end

      redirect_to(admin_pages_url, :notice => 'Page successfully created!')
    else
      redirect_to(admin_pages_url, :notice => 'Page was not created, check your input data and try again!')
    end
  end

  def update
    @page = Page.find(params[:id])
    @page.update_attributes(params[:page])

    if params[:header_contents].present?
      header_contents_last = PageContent.where(:page_id => @page, :location => "header").map { |value| value.id }
      header_contents_now = []
      params[:header_contents].each do |key, value|
        @header_content = PageContent.find(key.to_i)
        if @header_content
          @header_content.update_attribute(:content, value)
        else
          PageContent.create(:content => value, :page_id => @page.id, :location => "header")
        end
        header_contents_now << key.to_i
      end
      unusable_header_contents = header_contents_last - header_contents_now
      unusable_header_contents.each { |id| PageContent.find(id).destroy }
    else
      PageContent.where(:page_id => @page, :location => "header").delete_all
    end

    Rails.logger.info "++++++++++++++++++ #{params[:page_contents].inspect}"

    if params[:page_contents].present?
      page_contents_last = PageContent.where(:page_id => @page, :location => "content").map { |value| value.id }
      page_contents_now = []
      params[:page_contents].each do |key, value|
        @page_content = PageContent.find(key.to_i)
        if @page_content
          @page_content.update_attribute(:content, value)
        else
          PageContent.create(:content => value, :page_id => @page.id, :location => "content")
        end
        page_contents_now << key.to_i
      end
      unusable_page_contents = page_contents_last - page_contents_now
      unusable_page_contents.each { |id| PageContent.find(id).destroy }
    else
      PageContent.where(:page_id => @page, :location => "content").delete_all
    end

    if params[:sidebar_contents].present?
      sidebar_contents_last = PageContent.where(:page_id => @page, :location => "sidebar").map { |value| value.id }
      sidebar_contents_now = []
      params[:sidebar_contents].each do |key, value|
        @sidebar_content = PageContent.find(key.to_i)
        if @sidebar_content
          @sidebar_content.update_attribute(:content, value)
        else
          PageContent.create(:content => value, :page_id => @page.id, :location => "sidebar")
        end
        sidebar_contents_now << key.to_i
      end
      unusable_sidebar_contents = sidebar_contents_last - sidebar_contents_now
      unusable_sidebar_contents.each { |id| PageContent.find(id).destroy }
    else
      PageContent.where(:page_id => @page, :location => "sidebar").delete_all
    end

    params[:header_new].each { |key, value| PageContent.create(:content => value, :page_id => @page.id, :location => "header") } if params[:header_new].present?

    if params[:content_new].present?
      cleaned_values = []
      uncleaned_values = params[:content_new]
      keys = uncleaned_values.keys.sort{ |a,b| a.to_i <=> b.to_i }
      keys.each do |key|
        value = uncleaned_values["#{key.to_s}"]
        if value.include?("<p>&nbsp;</p>\r\n")
          cleaned_value = value.gsub!("<p>&nbsp;</p>\r\n","")
        else
          cleaned_value = value
        end
        cleaned_values << cleaned_value
      end
      cleaned_values.each { |value| PageContent.create(:content => value, :page_id => @page.id, :location => "content") }
    end

    params[:sidebar_new].each { |key, value| PageContent.create(:content => value, :page_id => @page.id, :location => "sidebar") } if params[:sidebar_new].present?
    
    respond_to do |format|
      format.html { redirect_to(admin_pages_url, :notice => 'Page successfully updated!') }
      format.xml { head :ok }
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(admin_pages_url, :notice => 'Page successfully deleted!') }
      format.xml  { head :ok }
    end
  end

  def update_sort
    pages = params[:pages]

    # deleting not usable root element of sortable array
    pages.delete('0')

    # define parent elements, which located in a root of sortable list
    pages.each do |key, value|
      page = Page.find(value['item_id'].to_i)
      page.update_attribute(:permalink, "undefined") if page.permalink.blank?
      if value['parent_id'].to_i > 0
        page.update_attributes(:position => key.to_i, :parent_id => value['parent_id'].to_i)
      else
        page.update_attributes(:position => key.to_i, :parent_id => nil)
      end
    end

    render :nothing => true
  end

  private

  def define_page
    @current_page = 'pages'
  end
end

