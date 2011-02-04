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

    Rails.logger.info "+++++  :header_positions   +++++++++++ #{params[:header_positions]}"

    header_positions = params[:header_positions]

    header_positions = header_positions.split(',')

    Rails.logger.info "+++++ parsed header_positions   +++++++++++ #{header_positions.inspect}"

    all_positions = {};

    unique_positions = {};
    custom_positions = {};
    tumblr_positions = {};
    fleakr_positions = {};
    vimeo_positions = {};

    cleaned_unique_positions = {};
    cleaned_custom_positions = {};
    cleaned_tumblr_positions = {};
    cleaned_fleakr_positions = {};
    cleaned_vimeo_positions = {};

    i = 0

    header_positions.each do |header_position|
      all_positions[header_position] = i
      i += 1
    end

    Rails.logger.info "+++++ all_positions >>>>>>>>>>>>> #{all_positions.inspect}"

    all_positions.each do |key, value|
      unique_positions[key] = value if key.include?("header")
      custom_positions[key] = value if key.include?("CustomModule")
      tumblr_positions[key] = value if key.include?("CacheTumblrPost")
      fleakr_positions[key] = value if key.include?("CacheFleakrGallery")
      vimeo_positions[key] = value if key.include?("CacheVimeoVideo")
    end

    Rails.logger.info "unique_positions = #{unique_positions.inspect}"
    Rails.logger.info "custom_positions = #{custom_positions.inspect}"
    Rails.logger.info "tumblr_positions = #{tumblr_positions.inspect}"
    Rails.logger.info "fleakr_positions = #{fleakr_positions.inspect}"
    Rails.logger.info "vimeo_positions = #{vimeo_positions.inspect}"

    unique_positions.each do |key, value|
      cleaned_unique_positions[key.sub("header_move_","").to_i] = value if key.include?("header_move_")
      cleaned_unique_positions[key.sub("header_old_","").to_i] = value if key.include?("header_old_")
    end

    custom_positions.each do |key, value|
      cleaned_custom_positions[key.sub("CustomModule","").to_i] = value if key.include?("CustomModule")
    end

    tumblr_positions.each do |key, value|
      cleaned_tumblr_positions[key.sub("CacheTumblrPost","").to_i] = value if key.include?("CacheTumblrPost")
    end

    fleakr_positions.each do |key, value|
      cleaned_fleakr_positions[key.sub("CacheFleakrGallery","").to_i] = value if key.include?("CacheFleakrGallery")
    end

    vimeo_positions.each do |key, value|
      cleaned_vimeo_positions[key.sub("CacheVimeoVideo","").to_i] = value if key.include?("CacheVimeoVideo")
    end

    Rails.logger.info "cleaned_unique_positions = #{cleaned_unique_positions.inspect}"
    Rails.logger.info "cleaned_custom_positions = #{cleaned_custom_positions.inspect}"
    Rails.logger.info "cleaned_tumblr_positions = #{cleaned_tumblr_positions.inspect}"
    Rails.logger.info "cleaned_fleakr_positions = #{cleaned_fleakr_positions.inspect}"
    Rails.logger.info "cleaned_vimeo_positions = #{cleaned_vimeo_positions.inspect}"

    if @page.save
      if params[:header_new].present?

        Rails.logger.info "++ params[:header_new] ++++++++++++++++ #{params[:header_new].inspect}"

        all_headers_content = params[:header_new]

        Rails.logger.info "++ all_headers_content >>>>>>>>>>>>>>>> #{all_headers_content.inspect}"

        headers_custom_modules = params[:header_new]["CustomModule"] if params[:header_new]["CustomModule"].present?
        
        Rails.logger.info "++ headers_custom_modules >>>>>>>>>>>>>>>> #{headers_custom_modules.inspect}"

        headers_tumblr_posts = params[:header_new]["CacheTumblrPost"] if params[:header_new]["CacheTumblrPost"].present?
        
        Rails.logger.info "++ headers_tumblr_posts >>>>>>>>>>>>>>>> #{headers_tumblr_posts.inspect}"

        headers_vimeo_videos = params[:header_new]["CacheVimeoVideo"] if params[:header_new]["CacheVimeoVideo"].present?
        
        Rails.logger.info "++ headers_vimeo_videos >>>>>>>>>>>>>>>> #{headers_vimeo_videos.inspect}"

        headers_fleakr_galleries = params[:header_new]["CacheFleakrGallery"] if params[:header_new]["CacheFleakrGallery"].present?
        
        Rails.logger.info "++ headers_fleakr_galleries >>>>>>>>>>>>>>>> #{headers_fleakr_galleries.inspect}"

        headers_unique_modules = params[:header_new].delete_if { |key,value| key=="CustomModule" || key=="CacheTumblrPost" || key=="CacheVimeoVideo" || key=="CacheFleakrGallery" }

        Rails.logger.info "++ headers_unique_modules >>>>>>>>>>>>>>>> #{headers_unique_modules.inspect}"

        if headers_unique_modules
          headers_unique_modules.each do |key, value|
            PageContent.create(:content => value,
                               :module_type => 'UniqueContentModule',
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
        Rails.logger.info "++++++++++++++++++ #{params[:content_new].inspect}"

        all_pages_content = params[:content_new]

        Rails.logger.info "++ all_pages_content ++++++++++++++++ #{all_pages_content.inspect}"

        pages_custom_modules = params[:content_new]["CustomModule"] if params[:content_new]["CustomModule"].present?

        Rails.logger.info "++ pages_custom_modules ++++++++++++++++ #{pages_custom_modules.inspect}"

        pages_tumblr_posts = params[:content_new]["CacheTumblrPost"] if params[:content_new]["CacheTumblrPost"].present?

        Rails.logger.info "++ pages_tumblr_posts ++++++++++++++++ #{pages_tumblr_posts.inspect}"

        pages_vimeo_videos = params[:content_new]["CacheVimeoVideo"] if params[:content_new]["CacheVimeoVideo"].present?

        Rails.logger.info "++ pages_vimeo_videos ++++++++++++++++ #{pages_vimeo_videos.inspect}"

        pages_fleakr_galleries = params[:content_new]["CacheFleakrGallery"] if params[:content_new]["CacheFleakrGallery"].present?

        Rails.logger.info "++ pages_fleakr_galleries ++++++++++++++++ #{pages_fleakr_galleries.inspect}"

        pages_unique_modules = params[:content_new].delete_if { |key,value| key=="CustomModule" || key=="CacheTumblrPost" || key=="CacheVimeoVideo" || key=="CacheFleakrGallery" }

        Rails.logger.info "++ pages_unique_modules ++++++++++++++++ #{pages_unique_modules.inspect}"

        if pages_unique_modules
          cleaned_values = []
          pages_unique_modules.each do |key, value|
            if value.include?("<p>&nbsp;</p>\r\n")
              cleaned_value = value.gsub!("<p>&nbsp;</p>\r\n","")
            else
              cleaned_value = value
            end
            cleaned_values << cleaned_value
          end
          cleaned_values.each { |value| PageContent.create(:content => value,
                                                           :module_type => 'UniqueContentModule',
                                                           :page_id => @page.id,
                                                           :location => "content") }
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
        Rails.logger.info "++++++++++++++++++ #{params[:sidebar_new].inspect}"

        all_sidebars_content = params[:sidebar_new]
        sidebars_custom_modules = params[:sidebar_new]["CustomModule"] if params[:sidebar_new]["CustomModule"].present?
        sidebars_tumblr_posts = params[:sidebar_new]["CacheTumblrPost"] if params[:sidebar_new]["CacheTumblrPost"].present?
        sidebars_vimeo_videos = params[:sidebar_new]["CacheVimeoVideo"] if params[:sidebar_new]["CacheVimeoVideo"].present?
        sidebars_fleakr_galleries = params[:sidebar_new]["CacheFleakrGallery"] if params[:sidebar_new]["CacheFleakrGallery"].present?
        sidebars_unique_modules = params[:sidebar_new].delete_if { |key,value| key=="CustomModule" || key=="CacheTumblrPost" || key=="CacheVimeoVideo" || key=="CacheFleakrGallery" }

        if sidebars_unique_modules
          sidebars_unique_modules.each do |key, value|
            PageContent.create(:content => value,
                               :module_type => 'UniqueContentModule',
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
    Rails.logger.info "++++++++++++++++++ #{params.inspect}"

    @page = Page.find(params[:id])
    @page.update_attributes(params[:page])

    if params[:header_contents].present?

      Rails.logger.info "!!!!!  params[:header_contents]  ++++++++++++ #{params[:header_contents].inspect}"

      header_contents_last = PageContent.where(:page_id => @page, :location => "header").map { |value| value.id }

      Rails.logger.info "!!!!!  header_contents_last  >>>>>>>>>>> #{header_contents_last.inspect}"

      header_contents_now = []
      params[:header_contents].each do |key, value|
        header_content = PageContent.find(key.to_i)

        Rails.logger.info "!!!!!  header_content  >>>>>>>>>>> #{header_content.inspect} >>>>>> key = #{key} value = #{value}"

        if header_content
          header_content.update_attribute(:content, value)
        else
          PageContent.create(:content => value, :page_id => @page, :location => "header")
        end
        header_contents_now << key.to_i
      end

      Rails.logger.info "!!!!!  header_contents_last >>>>>>>>>>> #{header_contents_last.inspect}"
      Rails.logger.info "!!!!!  header_contents_now >>>>>>>>>>> #{header_contents_now.inspect}"

      unusable_header_contents = header_contents_last - header_contents_now

      Rails.logger.info "!!!!!  header_contents_now >>>>>>>>>>> #{unusable_header_contents.inspect}"

      unusable_header_contents.each { |id| PageContent.find(id).destroy }
    else
      PageContent.where(:page_id => @page, :location => "header").delete_all
    end

    Rails.logger.info "++++++++++++++++++ #{params[:page_contents].inspect}"

    if params[:page_contents].present?
      page_contents_last = PageContent.where(:page_id => @page, :location => "content").map { |value| value.id }
      page_contents_now = []
      params[:page_contents].each do |key, value|
        page_content = PageContent.find(key.to_i)
        if page_content
          page_content.update_attribute(:content, value)
        else
          PageContent.create(:content => value, :page_id => @page, :location => "content")
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
        sidebar_content = PageContent.find(key.to_i)
        if sidebar_content
          sidebar_content.update_attribute(:content, value)
        else
          PageContent.create(:content => value, :page_id => @page, :location => "sidebar")
        end
        sidebar_contents_now << key.to_i
      end
      unusable_sidebar_contents = sidebar_contents_last - sidebar_contents_now
      unusable_sidebar_contents.each { |id| PageContent.find(id).destroy }
    else
      PageContent.where(:page_id => @page, :location => "sidebar").delete_all
    end


    if params[:header_new].present?

        Rails.logger.info "++ params[:header_new] ++++++++++++++++ #{params[:header_new].inspect}"

        all_headers_content = params[:header_new]

        Rails.logger.info "++ all_headers_content >>>>>>>>>>>>>>>> #{all_headers_content.inspect}"

        headers_custom_modules = params[:header_new]["CustomModule"] if params[:header_new]["CustomModule"].present?

        Rails.logger.info "++ headers_custom_modules >>>>>>>>>>>>>>>> #{headers_custom_modules.inspect}"

        headers_tumblr_posts = params[:header_new]["CacheTumblrPost"] if params[:header_new]["CacheTumblrPost"].present?

        Rails.logger.info "++ headers_tumblr_posts >>>>>>>>>>>>>>>> #{headers_tumblr_posts.inspect}"

        headers_vimeo_videos = params[:header_new]["CacheVimeoVideo"] if params[:header_new]["CacheVimeoVideo"].present?

        Rails.logger.info "++ headers_vimeo_videos >>>>>>>>>>>>>>>> #{headers_vimeo_videos.inspect}"

        headers_fleakr_galleries = params[:header_new]["CacheFleakrGallery"] if params[:header_new]["CacheFleakrGallery"].present?

        Rails.logger.info "++ headers_fleakr_galleries >>>>>>>>>>>>>>>> #{headers_fleakr_galleries.inspect}"

        headers_unique_modules = params[:header_new].delete_if { |key,value| key=="CustomModule" || key=="CacheTumblrPost" || key=="CacheVimeoVideo" || key=="CacheFleakrGallery" }

        Rails.logger.info "++ headers_unique_modules >>>>>>>>>>>>>>>> #{headers_unique_modules.inspect}"

        if headers_unique_modules
          headers_unique_modules.each do |key, value|
            PageContent.create(:content => value,
                               :module_type => 'UniqueContentModule',
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
        Rails.logger.info "++++++++++++++++++ #{params[:content_new].inspect}"

        all_pages_content = params[:content_new]

        Rails.logger.info "++ all_pages_content ++++++++++++++++ #{all_pages_content.inspect}"

        pages_custom_modules = params[:content_new]["CustomModule"] if params[:content_new]["CustomModule"].present?

        Rails.logger.info "++ pages_custom_modules ++++++++++++++++ #{pages_custom_modules.inspect}"

        pages_tumblr_posts = params[:content_new]["CacheTumblrPost"] if params[:content_new]["CacheTumblrPost"].present?

        Rails.logger.info "++ pages_tumblr_posts ++++++++++++++++ #{pages_tumblr_posts.inspect}"

        pages_vimeo_videos = params[:content_new]["CacheVimeoVideo"] if params[:content_new]["CacheVimeoVideo"].present?

        Rails.logger.info "++ pages_vimeo_videos ++++++++++++++++ #{pages_vimeo_videos.inspect}"

        pages_fleakr_galleries = params[:content_new]["CacheFleakrGallery"] if params[:content_new]["CacheFleakrGallery"].present?

        Rails.logger.info "++ pages_fleakr_galleries ++++++++++++++++ #{pages_fleakr_galleries.inspect}"

        pages_unique_modules = params[:content_new].delete_if { |key,value| key=="CustomModule" || key=="CacheTumblrPost" || key=="CacheVimeoVideo" || key=="CacheFleakrGallery" }

        Rails.logger.info "++ pages_unique_modules ++++++++++++++++ #{pages_unique_modules.inspect}"

        if pages_unique_modules
          cleaned_values = []
          pages_unique_modules.each do |key, value|
            if value.include?("<p>&nbsp;</p>\r\n")
              cleaned_value = value.gsub!("<p>&nbsp;</p>\r\n","")
            else
              cleaned_value = value
            end
            cleaned_values << cleaned_value
          end
          cleaned_values.each { |value| PageContent.create(:content => value,
                                                           :module_type => 'UniqueContentModule',
                                                           :page_id => @page.id,
                                                           :location => "content") }
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
        Rails.logger.info "++++++++++++++++++ #{params[:sidebar_new].inspect}"

        all_sidebars_content = params[:sidebar_new]
        sidebars_custom_modules = params[:sidebar_new]["CustomModule"] if params[:sidebar_new]["CustomModule"].present?
        sidebars_tumblr_posts = params[:sidebar_new]["CacheTumblrPost"] if params[:sidebar_new]["CacheTumblrPost"].present?
        sidebars_vimeo_videos = params[:sidebar_new]["CacheVimeoVideo"] if params[:sidebar_new]["CacheVimeoVideo"].present?
        sidebars_fleakr_galleries = params[:sidebar_new]["CacheFleakrGallery"] if params[:sidebar_new]["CacheFleakrGallery"].present?
        sidebars_unique_modules = params[:sidebar_new].delete_if { |key,value| key=="CustomModule" || key=="CacheTumblrPost" || key=="CacheVimeoVideo" || key=="CacheFleakrGallery" }

        if sidebars_unique_modules
          sidebars_unique_modules.each do |key, value|
            PageContent.create(:content => value,
                               :module_type => 'UniqueContentModule',
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

