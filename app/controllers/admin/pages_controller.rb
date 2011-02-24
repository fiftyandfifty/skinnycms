class Admin::PagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"
  uses_tiny_mce :options => {:theme_advanced_buttons1_add => %w{assets}},
                :raw_options => "setup : function(ed) { ed.addButton('assets', { title : 'Assets', image : '/images/skinnycms/admin/ico-l.gif', onclick : function() { $('#assets_popup').dialog('open'); }});}"
  respond_to :html, :xml


  def index
    @title = "Pages"
    
    @nav_names = {}
    @navigations = {}
    @navs = Navigation.all(:order => :id)
    @navs.each do |nav|
      @nav_names[nav.id] = nav.title
      @navigations[nav.id] = PagesToNavigation.public_and_redirect_in_root_for(nav.title)
    end
    
    @private_pages = []
    not_on_nav = Page.not_on_nav
    not_on_nav.each do |p|
      @private_pages << PagesToNavigation.new(:page_id => p.id)
    end

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
    @templates = Template.all(:order => :title)
    @navigations = Navigation.all(:order => :title)
    @pages_to_navigations = PagesToNavigation.all
    
    available_modules = CustomModule.all + CacheTumblrPost.all + CacheVimeoVideo.all + CacheFleakrGallery.all
    available_modules.unshift('Tumblr Basic') if CacheTumblrPost.present?
    @available_modules = available_modules.paginate :page => params[:page], :per_page => 10
    @assets = Asset.all.paginate :page => params[:page], :per_page => 3

    respond_to do |format|
      format.html
      format.xml { render :xml => @page }
    end
  end

  def edit
    @title = "Edit Page"
    @page = Page.find(params[:id])
    @templates = Template.all(:order => :title)
    @navigations = Navigation.all(:order => :id)
    @pages_to_navigations = PagesToNavigation.all

    @header_contents = PageContent.where(:page_id => @page, :location => 'header').order(:position)
    @page_contents = PageContent.where(:page_id => @page, :location => 'content').order(:position)
    @sidebar_contents = PageContent.where(:page_id => @page, :location => 'sidebar').order(:position)

    available_modules = CustomModule.all + CacheTumblrPost.all + CacheVimeoVideo.all + CacheFleakrGallery.all
    available_modules.unshift('Tumblr Basic') if CacheTumblrPost.present?
    @available_modules = available_modules.paginate :page => params[:page], :per_page => 10
  end

  def create
    Rails.logger.info "++++++++++++++++ #{params.inspect}"
    @page = Page.new(params[:page])

    # Reordering logic for header content

    header_positions = params[:header_positions].split(',')

    headers_all_positions = {};

    headers_unique_positions = {};
    headers_custom_positions = {};
    headers_tumblr_positions = {};
    headers_fleakr_positions = {};
    headers_vimeo_positions = {};

    headers_cleaned_unique_positions = {};
    headers_cleaned_custom_positions = {};
    headers_cleaned_tumblr_positions = {};
    headers_cleaned_fleakr_positions = {};
    headers_cleaned_vimeo_positions = {};

    i = 0

    header_positions.each do |header_position|
      headers_all_positions[header_position] = i
      i += 1
    end

    headers_all_positions.each do |key, value|
      headers_unique_positions[key] = value if key.include?("header")
      headers_custom_positions[key] = value if key.include?("CustomModule")
      headers_tumblr_positions[key] = value if key.include?("CacheTumblrPost")
      headers_fleakr_positions[key] = value if key.include?("CacheFleakrGallery")
      headers_vimeo_positions[key] = value if key.include?("CacheVimeoVideo")
    end

    headers_unique_positions.each do |key, value|
      headers_cleaned_unique_positions[key.sub("header_move_","").to_i] = value if key.include?("header_move_")
      headers_cleaned_unique_positions[key.sub("header_old_","").to_i] = value if key.include?("header_old_")
    end

    headers_custom_positions.each do |key, value|
      headers_cleaned_custom_positions[key.sub("CustomModule","").to_i] = value if key.include?("CustomModule")
    end

    headers_tumblr_positions.each do |key, value|
      headers_cleaned_tumblr_positions[key.sub("CacheTumblrPost","").to_i] = value if key.include?("CacheTumblrPost")
    end

    headers_fleakr_positions.each do |key, value|
      headers_cleaned_fleakr_positions[key.sub("CacheFleakrGallery","").to_i] = value if key.include?("CacheFleakrGallery")
    end

    headers_vimeo_positions.each do |key, value|
      headers_cleaned_vimeo_positions[key.sub("CacheVimeoVideo","").to_i] = value if key.include?("CacheVimeoVideo")
    end

    # Reordering logic for left content

    contents_positions = params[:content_positions].split(',')

    contents_all_positions = {};

    contents_unique_positions = {};
    contents_custom_positions = {};
    contents_tumblr_positions = {};
    contents_fleakr_positions = {};
    contents_vimeo_positions = {};

    contents_cleaned_unique_positions = {};
    contents_cleaned_custom_positions = {};
    contents_cleaned_tumblr_positions = {};
    contents_cleaned_fleakr_positions = {};
    contents_cleaned_vimeo_positions = {};

    i = 0

    contents_positions.each do |contents_position|
      contents_all_positions[contents_position] = i
      i += 1
    end

    contents_all_positions.each do |key, value|
      contents_unique_positions[key] = value if key.include?("content")
      contents_custom_positions[key] = value if key.include?("CustomModule")
      contents_tumblr_positions[key] = value if key.include?("CacheTumblrPost")
      contents_fleakr_positions[key] = value if key.include?("CacheFleakrGallery")
      contents_vimeo_positions[key] = value if key.include?("CacheVimeoVideo")
    end

    contents_unique_positions.each do |key, value|
      contents_cleaned_unique_positions[key.sub("content_move_","").to_i] = value if key.include?("content_move_")
      contents_cleaned_unique_positions[key.sub("content_old_","").to_i] = value if key.include?("content_old_")
    end

    contents_custom_positions.each do |key, value|
      contents_cleaned_custom_positions[key.sub("CustomModule","").to_i] = value if key.include?("CustomModule")
    end

    contents_tumblr_positions.each do |key, value|
      contents_cleaned_tumblr_positions[key.sub("CacheTumblrPost","").to_i] = value if key.include?("CacheTumblrPost")
    end

    contents_fleakr_positions.each do |key, value|
      contents_cleaned_fleakr_positions[key.sub("CacheFleakrGallery","").to_i] = value if key.include?("CacheFleakrGallery")
    end

    contents_vimeo_positions.each do |key, value|
      contents_cleaned_vimeo_positions[key.sub("CacheVimeoVideo","").to_i] = value if key.include?("CacheVimeoVideo")
    end

    # Reordering logic for sidebar content

    sidebars_positions = params[:sidebar_positions].split(',')

    sidebars_all_positions = {};

    sidebars_unique_positions = {};
    sidebars_custom_positions = {};
    sidebars_tumblr_positions = {};
    sidebars_fleakr_positions = {};
    sidebars_vimeo_positions = {};

    sidebars_cleaned_unique_positions = {};
    sidebars_cleaned_custom_positions = {};
    sidebars_cleaned_tumblr_positions = {};
    sidebars_cleaned_fleakr_positions = {};
    sidebars_cleaned_vimeo_positions = {};

    i = 0

    sidebars_positions.each do |sidebars_position|
      sidebars_all_positions[sidebars_position] = i
      i += 1
    end

    sidebars_all_positions.each do |key, value|
      sidebars_unique_positions[key] = value if key.include?("sidebar")
      sidebars_custom_positions[key] = value if key.include?("CustomModule")
      sidebars_tumblr_positions[key] = value if key.include?("CacheTumblrPost")
      sidebars_fleakr_positions[key] = value if key.include?("CacheFleakrGallery")
      sidebars_vimeo_positions[key] = value if key.include?("CacheVimeoVideo")
    end

    sidebars_unique_positions.each do |key, value|
      sidebars_cleaned_unique_positions[key.sub("sidebar_move_","").to_i] = value if key.include?("sidebar_move_")
      sidebars_cleaned_unique_positions[key.sub("sidebar_old_","").to_i] = value if key.include?("sidebar_old_")
    end

    sidebars_custom_positions.each do |key, value|
      sidebars_cleaned_custom_positions[key.sub("CustomModule","").to_i] = value if key.include?("CustomModule")
    end

    sidebars_tumblr_positions.each do |key, value|
      sidebars_cleaned_tumblr_positions[key.sub("CacheTumblrPost","").to_i] = value if key.include?("CacheTumblrPost")
    end

    sidebars_fleakr_positions.each do |key, value|
      sidebars_cleaned_fleakr_positions[key.sub("CacheFleakrGallery","").to_i] = value if key.include?("CacheFleakrGallery")
    end

    sidebars_vimeo_positions.each do |key, value|
      sidebars_cleaned_vimeo_positions[key.sub("CacheVimeoVideo","").to_i] = value if key.include?("CacheVimeoVideo")
    end

    if @page.save
      params[:navigation].each do |nav_id, value|
        if value.present?
          parent_id = value == 'root' ? 0 : value.to_i
          PagesToNavigation.create(:navigation_id => nav_id.to_i, :page_id => @page.id, :parent_id => parent_id)
        end
      end
      @page.update_attribute(:template_id, Template.find(:first, :conditions => { :title => 'Home Page' }).id) if params[:page][:template_id].blank?

      # Create logic for header content

      if params[:header_new].present?

        headers_custom_modules = params[:header_new]["CustomModule"] if params[:header_new]["CustomModule"].present?
        headers_tumblr_basic = params[:header_new]["tumblr_basic"] if params[:header_new]["tumblr_basic"].present?
        headers_tumblr_posts = params[:header_new]["CacheTumblrPost"] if params[:header_new]["CacheTumblrPost"].present?
        headers_vimeo_videos = params[:header_new]["CacheVimeoVideo"] if params[:header_new]["CacheVimeoVideo"].present?
        headers_fleakr_galleries = params[:header_new]["CacheFleakrGallery"] if params[:header_new]["CacheFleakrGallery"].present?
        headers_unique_modules = params[:header_new].delete_if { |key,value| key=="CustomModule" || key=="CacheTumblrPost" || key=="CacheVimeoVideo" || key=="CacheFleakrGallery" || key=="tumblr_basic"}

        if headers_unique_modules
          cleaned_values = {}
          headers_unique_modules.each do |key, value|
            if value.include?("<p>&nbsp;</p>\r\n")
              cleaned_value = value.gsub!("<p>&nbsp;</p>\r\n","")
            else
              cleaned_value = value
            end
            cleaned_values[key] = cleaned_value
          end
          cleaned_values.each { |key, value| PageContent.create(:content => value,
                                                                 :module_type => 'UniqueContentModule',
                                                                 :page_id => @page.id,
                                                                 :location => "header",
                                                                 :position => headers_cleaned_unique_positions[key.to_i]) }
        end

        if headers_custom_modules
          headers_custom_modules.each do |key, value|
            PageContent.create(:content => CustomModule.find(value).header,
                               :module_type => 'CustomModule',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "header",
                               :position => headers_cleaned_custom_positions[value.to_i])
          end
        end

        PageContent.create(:module_type => 'Tumblr Basic', :page_id => @page.id, :location => "header", :position => headers_tumblr_basic.keys[0].to_i) if headers_tumblr_basic

        if headers_tumblr_posts
          headers_tumblr_posts.each do |key, value|
            PageContent.create(:content => CacheTumblrPost.find(:first, :conditions => { :tumblr_post_id => value }).desc,
                               :module_type => 'CacheTumblrPost',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "header",
                               :position => headers_cleaned_tumblr_positions[value.to_i])
          end
        end

        if headers_vimeo_videos
          headers_vimeo_videos.each do |key, value|
            PageContent.create(:content => CacheVimeoVideo.find(:first, :conditions => { :vimeo_video_id => value }).url,
                               :module_type => 'CacheVimeoVideo',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "header",
                               :position => headers_cleaned_vimeo_positions[value.to_i])
          end
        end

        if headers_fleakr_galleries
          headers_fleakr_galleries.each do |key, value|
            PageContent.create(:content => CacheFleakrGallery.find(:first, :conditions => { :fleakr_gallery_id => value }).title,
                                                                   :module_type => 'CacheFleakrGallery',
                                                                   :module_id => value,
                                                                   :page_id => @page.id,
                                                                   :location => "header",
                                                                   :position => headers_cleaned_fleakr_positions[value.to_i])
          end
        end
      end

      # Create logic for left content

      if params[:content_new].present?

        pages_custom_modules = params[:content_new]["CustomModule"] if params[:content_new]["CustomModule"].present?
        pages_tumblr_basic = params[:content_new]["tumblr_basic"] if params[:content_new]["tumblr_basic"].present?
        pages_tumblr_posts = params[:content_new]["CacheTumblrPost"] if params[:content_new]["CacheTumblrPost"].present?
        pages_vimeo_videos = params[:content_new]["CacheVimeoVideo"] if params[:content_new]["CacheVimeoVideo"].present?
        pages_fleakr_galleries = params[:content_new]["CacheFleakrGallery"] if params[:content_new]["CacheFleakrGallery"].present?
        pages_unique_modules = params[:content_new].delete_if { |key,value| key=="CustomModule" || key=="CacheTumblrPost" || key=="CacheVimeoVideo" || key=="CacheFleakrGallery" || key=="tumblr_basic" }

        if pages_unique_modules
          cleaned_values = {}
          pages_unique_modules.each do |key, value|
            if value.include?("<p>&nbsp;</p>\r\n")
              cleaned_value = value.gsub!("<p>&nbsp;</p>\r\n","")
            else
              cleaned_value = value
            end
            cleaned_values[key] = cleaned_value
          end
          cleaned_values.each { |key, value| PageContent.create(:content => value,
                                                           :module_type => 'UniqueContentModule',
                                                           :page_id => @page.id,
                                                           :location => "content",
                                                           :position => contents_cleaned_unique_positions[key.to_i]) }
        end 

        if pages_custom_modules
          pages_custom_modules.each do |key, value|
            PageContent.create(:content => CustomModule.find(value).content,
                               :module_type => 'CustomModule',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "content",
                               :position => contents_cleaned_custom_positions[value.to_i])
          end
        end

        PageContent.create(:module_type => 'Tumblr Basic', :page_id => @page.id, :location => "content", :position => pages_tumblr_basic.keys[0].to_i) if pages_tumblr_basic

        if pages_tumblr_posts
          pages_tumblr_posts.each do |key, value|
            PageContent.create(:content => CacheTumblrPost.find(:first, :conditions => { :tumblr_post_id => value }).desc,
                               :module_type => 'CacheTumblrPost',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "content",
                               :position => contents_cleaned_tumblr_positions[value.to_i])
          end
        end

        if pages_vimeo_videos
          pages_vimeo_videos.each do |key, value|
            PageContent.create(:content => CacheVimeoVideo.find(:first, :conditions => { :vimeo_video_id => value }).url,
                               :module_type => 'CacheVimeoVideo',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "content",
                               :position => contents_cleaned_vimeo_positions[value.to_i])
          end
        end

        if pages_fleakr_galleries
          pages_fleakr_galleries.each do |key, value|
            PageContent.create(:content => CacheFleakrGallery.find(:first, :conditions => { :fleakr_gallery_id => value }).title,
                                                                   :module_type => 'CacheFleakrGallery',
                                                                   :module_id => value,
                                                                   :page_id => @page.id,
                                                                   :location => "content",
                                                                   :position => contents_cleaned_fleakr_positions[value.to_i])
          end
        end
      end

      # Create logic for sidebar content

      if params[:sidebar_new].present?

        sidebars_custom_modules = params[:sidebar_new]["CustomModule"] if params[:sidebar_new]["CustomModule"].present?
        sidebars_tumblr_basic = params[:sidebar_new]["tumblr_basic"] if params[:sidebar_new]["tumblr_basic"].present?
        sidebars_tumblr_posts = params[:sidebar_new]["CacheTumblrPost"] if params[:sidebar_new]["CacheTumblrPost"].present?
        sidebars_vimeo_videos = params[:sidebar_new]["CacheVimeoVideo"] if params[:sidebar_new]["CacheVimeoVideo"].present?
        sidebars_fleakr_galleries = params[:sidebar_new]["CacheFleakrGallery"] if params[:sidebar_new]["CacheFleakrGallery"].present?
        sidebars_unique_modules = params[:sidebar_new].delete_if { |key,value| key=="CustomModule" || key=="CacheTumblrPost" || key=="CacheVimeoVideo" || key=="CacheFleakrGallery" || key=="tumblr_basic" }

        if sidebars_unique_modules
          cleaned_values = {}
          sidebars_unique_modules.each do |key, value|
            if value.include?("<p>&nbsp;</p>\r\n")
              cleaned_value = value.gsub!("<p>&nbsp;</p>\r\n","")
            else
              cleaned_value = value
            end
            cleaned_values[key] = cleaned_value
          end
          cleaned_values.each { |key, value| PageContent.create(:content => value,
                                                                :module_type => 'UniqueContentModule',
                                                                :page_id => @page.id,
                                                                :location => "sidebar",
                                                                :position => sidebars_cleaned_unique_positions[key.to_i]) }
        end

        if sidebars_custom_modules
          sidebars_custom_modules.each do |key, value|
            PageContent.create(:content => CustomModule.find(value).sidebar,
                               :module_type => 'CustomModule',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "sidebar",
                               :position => sidebars_cleaned_custom_positions[value.to_i])
          end
        end

        PageContent.create(:module_type => 'Tumblr Basic', :page_id => @page.id, :location => "sidebar", :position => sidebars_tumblr_basic.keys[0].to_i) if sidebars_tumblr_basic

        if sidebars_tumblr_posts
          sidebars_tumblr_posts.each do |key, value|
            PageContent.create(:content => CacheTumblrPost.find(:first, :conditions => { :tumblr_post_id => value }).desc,
                               :module_type => 'CacheTumblrPost',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "sidebar",
                               :position => sidebars_cleaned_tumblr_positions[value.to_i])
          end
        end

        if sidebars_vimeo_videos
          sidebars_vimeo_videos.each do |key, value|
            PageContent.create(:content => CacheVimeoVideo.find(:first, :conditions => { :vimeo_video_id => value }).url,
                               :module_type => 'CacheVimeoVideo',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "sidebar",
                               :position => sidebars_cleaned_vimeo_positions[value.to_i])
          end
        end

        if sidebars_fleakr_galleries
          sidebars_fleakr_galleries.each do |key, value|
            PageContent.create(:content => CacheFleakrGallery.find(:first, :conditions => { :fleakr_gallery_id => value }).title,
                                                                   :module_type => 'CacheFleakrGallery',
                                                                   :module_id => value,
                                                                   :page_id => @page.id,
                                                                   :location => "sidebar",
                                                                   :position => sidebars_cleaned_fleakr_positions[value.to_i])
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

    params[:navigation].each do |nav_id, value|
      pages_to_navigation = PagesToNavigation.find(:first, :conditions => { :navigation_id => nav_id, :page_id => @page.id })
      if value.present?
        parent_id = value == 'root' ? 0 : value.to_i
        if pages_to_navigation.present?
          pages_to_navigation.update_attribute(:parent_id, parent_id)
        else
          PagesToNavigation.create(:navigation_id => nav_id.to_i, :page_id => @page.id, :parent_id => parent_id)
        end
      else
        pages_to_navigation.delete if pages_to_navigation.present?
      end
    end

    # Reordering logic for header content

    header_positions = params[:header_positions].split(',')

    headers_all_positions = {};

    headers_unique_positions = {};
    headers_custom_positions = {};
    headers_tumblr_positions = {};
    headers_fleakr_positions = {};
    headers_vimeo_positions = {};

    headers_cleaned_unique_positions = {};
    headers_cleaned_custom_positions = {};
    headers_cleaned_tumblr_positions = {};
    headers_cleaned_fleakr_positions = {};
    headers_cleaned_vimeo_positions = {};

    i = 0

    header_positions.each do |header_position|
      headers_all_positions[header_position] = i
      i += 1
    end

    headers_all_positions.each do |key, value|
      headers_unique_positions[key] = value if key.include?("header")
      headers_custom_positions[key] = value if key.include?("CustomModule")
      headers_tumblr_positions[key] = value if key.include?("CacheTumblrPost")
      headers_fleakr_positions[key] = value if key.include?("CacheFleakrGallery")
      headers_vimeo_positions[key] = value if key.include?("CacheVimeoVideo")
    end

    headers_unique_positions.each do |key, value|
      headers_cleaned_unique_positions[key.sub("header_move_","").to_i] = value if key.include?("header_move_")
      headers_cleaned_unique_positions[key.sub("header_old_","").to_i] = value if key.include?("header_old_")
    end

    headers_custom_positions.each do |key, value|
      headers_cleaned_custom_positions[key.sub("CustomModule","").to_i] = value if key.include?("CustomModule")
    end

    headers_tumblr_positions.each do |key, value|
      headers_cleaned_tumblr_positions[key.sub("CacheTumblrPost","").to_i] = value if key.include?("CacheTumblrPost")
    end

    headers_fleakr_positions.each do |key, value|
      headers_cleaned_fleakr_positions[key.sub("CacheFleakrGallery","").to_i] = value if key.include?("CacheFleakrGallery")
    end

    headers_vimeo_positions.each do |key, value|
      headers_cleaned_vimeo_positions[key.sub("CacheVimeoVideo","").to_i] = value if key.include?("CacheVimeoVideo")
    end

    # Reordering logic for left content

    contents_positions = params[:content_positions].split(',')

    contents_all_positions = {};

    contents_unique_positions = {};
    contents_custom_positions = {};
    contents_tumblr_positions = {};
    contents_fleakr_positions = {};
    contents_vimeo_positions = {};

    contents_cleaned_unique_positions = {};
    contents_cleaned_custom_positions = {};
    contents_cleaned_tumblr_positions = {};
    contents_cleaned_fleakr_positions = {};
    contents_cleaned_vimeo_positions = {};

    i = 0

    contents_positions.each do |contents_position|
      contents_all_positions[contents_position] = i
      i += 1
    end

    contents_all_positions.each do |key, value|
      contents_unique_positions[key] = value if key.include?("content")
      contents_custom_positions[key] = value if key.include?("CustomModule")
      contents_tumblr_positions[key] = value if key.include?("CacheTumblrPost")
      contents_fleakr_positions[key] = value if key.include?("CacheFleakrGallery")
      contents_vimeo_positions[key] = value if key.include?("CacheVimeoVideo")
    end

    contents_unique_positions.each do |key, value|
      contents_cleaned_unique_positions[key.sub("content_move_","").to_i] = value if key.include?("content_move_")
      contents_cleaned_unique_positions[key.sub("content_old_","").to_i] = value if key.include?("content_old_")
    end

    contents_custom_positions.each do |key, value|
      contents_cleaned_custom_positions[key.sub("CustomModule","").to_i] = value if key.include?("CustomModule")
    end

    contents_tumblr_positions.each do |key, value|
      contents_cleaned_tumblr_positions[key.sub("CacheTumblrPost","").to_i] = value if key.include?("CacheTumblrPost")
    end

    contents_fleakr_positions.each do |key, value|
      contents_cleaned_fleakr_positions[key.sub("CacheFleakrGallery","").to_i] = value if key.include?("CacheFleakrGallery")
    end

    contents_vimeo_positions.each do |key, value|
      contents_cleaned_vimeo_positions[key.sub("CacheVimeoVideo","").to_i] = value if key.include?("CacheVimeoVideo")
    end

    # Reordering logic for sidebar content

    sidebars_positions = params[:sidebar_positions].split(',')

    sidebars_all_positions = {};

    sidebars_unique_positions = {};
    sidebars_custom_positions = {};
    sidebars_tumblr_positions = {};
    sidebars_fleakr_positions = {};
    sidebars_vimeo_positions = {};

    sidebars_cleaned_unique_positions = {};
    sidebars_cleaned_custom_positions = {};
    sidebars_cleaned_tumblr_positions = {};
    sidebars_cleaned_fleakr_positions = {};
    sidebars_cleaned_vimeo_positions = {};

    i = 0

    sidebars_positions.each do |sidebars_position|
      sidebars_all_positions[sidebars_position] = i
      i += 1
    end

    sidebars_all_positions.each do |key, value|
      sidebars_unique_positions[key] = value if key.include?("sidebar")
      sidebars_custom_positions[key] = value if key.include?("CustomModule")
      sidebars_tumblr_positions[key] = value if key.include?("CacheTumblrPost")
      sidebars_fleakr_positions[key] = value if key.include?("CacheFleakrGallery")
      sidebars_vimeo_positions[key] = value if key.include?("CacheVimeoVideo")
    end

    sidebars_unique_positions.each do |key, value|
      sidebars_cleaned_unique_positions[key.sub("sidebar_move_","").to_i] = value if key.include?("sidebar_move_")
      sidebars_cleaned_unique_positions[key.sub("sidebar_old_","").to_i] = value if key.include?("sidebar_old_")
    end

    sidebars_custom_positions.each do |key, value|
      sidebars_cleaned_custom_positions[key.sub("CustomModule","").to_i] = value if key.include?("CustomModule")
    end

    sidebars_tumblr_positions.each do |key, value|
      sidebars_cleaned_tumblr_positions[key.sub("CacheTumblrPost","").to_i] = value if key.include?("CacheTumblrPost")
    end

    sidebars_fleakr_positions.each do |key, value|
      sidebars_cleaned_fleakr_positions[key.sub("CacheFleakrGallery","").to_i] = value if key.include?("CacheFleakrGallery")
    end

    sidebars_vimeo_positions.each do |key, value|
      sidebars_cleaned_vimeo_positions[key.sub("CacheVimeoVideo","").to_i] = value if key.include?("CacheVimeoVideo")
    end

    # Define old contents

    header_contents_last = PageContent.where(:page_id => @page, :location => "header").map { |value| value.id }
    page_contents_last = PageContent.where(:page_id => @page, :location => "content").map { |value| value.id }
    sidebar_contents_last = PageContent.where(:page_id => @page, :location => "sidebar").map { |value| value.id }

    # Create logic for header content

      if params[:header_new].present?

        headers_custom_modules = params[:header_new]["CustomModule"] if params[:header_new]["CustomModule"].present?
        headers_tumblr_posts = params[:header_new]["CacheTumblrPost"] if params[:header_new]["CacheTumblrPost"].present?
        headers_vimeo_videos = params[:header_new]["CacheVimeoVideo"] if params[:header_new]["CacheVimeoVideo"].present?
        headers_fleakr_galleries = params[:header_new]["CacheFleakrGallery"] if params[:header_new]["CacheFleakrGallery"].present?
        headers_unique_modules = params[:header_new].delete_if { |key,value| key=="CustomModule" || key=="CacheTumblrPost" || key=="CacheVimeoVideo" || key=="CacheFleakrGallery" }

        if headers_unique_modules
          cleaned_values = {}
          headers_unique_modules.each do |key, value|
            if value.include?("<p>&nbsp;</p>\r\n")
              cleaned_value = value.gsub!("<p>&nbsp;</p>\r\n","")
            else
              cleaned_value = value
            end
            cleaned_values[key] = cleaned_value
          end
          Rails.logger.info "!!!!!!cleaned_values #{cleaned_values}"
          cleaned_values.each { |key, value| PageContent.create(:content => value,
                                                                :module_type => 'UniqueContentModule',
                                                                :page_id => @page.id,
                                                                :location => "header",
                                                                :position => headers_cleaned_unique_positions[key.to_i]) }
        end

        if headers_custom_modules
          Rails.logger.info "!!!!!!headers_cleaned_custom_positions #{headers_cleaned_custom_positions}"
          Rails.logger.info "!!!!!!headers_custom_modules #{headers_custom_modules}"
          headers_custom_modules.each do |key, value|
            PageContent.create(:content => CustomModule.find(value).header,
                               :module_type => 'CustomModule',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "header",
                               :position => headers_cleaned_custom_positions[value.to_i])
          end
        end

        if headers_tumblr_posts
          Rails.logger.info "!!!!!!headers_cleaned_tumblr_positions #{headers_cleaned_tumblr_positions}"
          Rails.logger.info "!!!!!!headers_tumblr_posts #{headers_tumblr_posts}"
          headers_tumblr_posts.each do |key, value|
            PageContent.create(:content => CacheTumblrPost.find(:first, :conditions => { :tumblr_post_id => value }).desc,
                               :module_type => 'CacheTumblrPost',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "header",
                               :position => headers_cleaned_tumblr_positions[value.to_i])
          end
        end

        if headers_vimeo_videos
          Rails.logger.info "!!!!!!headers_cleaned_vimeo_positions #{headers_cleaned_vimeo_positions}"
          Rails.logger.info "!!!!!!headers_vimeo_videos #{headers_vimeo_videos}"
          headers_vimeo_videos.each do |key, value|
            PageContent.create(:content => CacheVimeoVideo.find(:first, :conditions => { :vimeo_video_id => value }).url,
                               :module_type => 'CacheVimeoVideo',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "header",
                               :position => headers_cleaned_vimeo_positions[value.to_i])
          end
        end

        if headers_fleakr_galleries
           Rails.logger.info "!!!!!!headers_cleaned_fleakr_positions #{headers_cleaned_fleakr_positions}"
          Rails.logger.info "!!!!!!headers_fleakr_galleries #{headers_fleakr_galleries}"
          headers_fleakr_galleries.each do |key, value|
            PageContent.create(:content => CacheFleakrGallery.find(:first, :conditions => { :fleakr_gallery_id => value }).title,
                                                                   :module_type => 'CacheFleakrGallery',
                                                                   :module_id => value,
                                                                   :page_id => @page.id,
                                                                   :location => "header",
                                                                   :position => headers_cleaned_fleakr_positions[value.to_i])
          end
        end
      end

      # Create logic for left content

      if params[:content_new].present?

        pages_custom_modules = params[:content_new]["CustomModule"] if params[:content_new]["CustomModule"].present?
        pages_tumblr_posts = params[:content_new]["CacheTumblrPost"] if params[:content_new]["CacheTumblrPost"].present?
        pages_vimeo_videos = params[:content_new]["CacheVimeoVideo"] if params[:content_new]["CacheVimeoVideo"].present?
        pages_fleakr_galleries = params[:content_new]["CacheFleakrGallery"] if params[:content_new]["CacheFleakrGallery"].present?
        pages_unique_modules = params[:content_new].delete_if { |key,value| key=="CustomModule" || key=="CacheTumblrPost" || key=="CacheVimeoVideo" || key=="CacheFleakrGallery" }

        if pages_unique_modules
          cleaned_values = {}
          pages_unique_modules.each do |key, value|
            if value.include?("<p>&nbsp;</p>\r\n")
              cleaned_value = value.gsub!("<p>&nbsp;</p>\r\n","")
            else
              cleaned_value = value
            end
            cleaned_values[key] = cleaned_value
          end
          cleaned_values.each { |key, value| PageContent.create(:content => value,
                                                           :module_type => 'UniqueContentModule',
                                                           :page_id => @page.id,
                                                           :location => "content",
                                                           :position => contents_cleaned_unique_positions[key.to_i]) }
        end

        if pages_custom_modules
          pages_custom_modules.each do |key, value|
            PageContent.create(:content => CustomModule.find(value).content,
                               :module_type => 'CustomModule',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "content",
                               :position => contents_cleaned_custom_positions[value.to_i])
          end
        end

        if pages_tumblr_posts
          pages_tumblr_posts.each do |key, value|
            PageContent.create(:content => CacheTumblrPost.find(:first, :conditions => { :tumblr_post_id => value }).desc,
                               :module_type => 'CacheTumblrPost',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "content",
                               :position => contents_cleaned_tumblr_positions[value.to_i])
          end
        end

        if pages_vimeo_videos
          pages_vimeo_videos.each do |key, value|
            PageContent.create(:content => CacheVimeoVideo.find(:first, :conditions => { :vimeo_video_id => value }).url,
                               :module_type => 'CacheVimeoVideo',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "content",
                               :position => contents_cleaned_vimeo_positions[value.to_i])
          end
        end

        if pages_fleakr_galleries
          pages_fleakr_galleries.each do |key, value|
            PageContent.create(:content => CacheFleakrGallery.find(:first, :conditions => { :fleakr_gallery_id => value }).title,
                                                                   :module_type => 'CacheFleakrGallery',
                                                                   :module_id => value,
                                                                   :page_id => @page.id,
                                                                   :location => "content",
                                                                   :position => contents_cleaned_fleakr_positions[value.to_i])
          end
        end
      end

      # Create logic for sidebar content

      if params[:sidebar_new].present?

        sidebars_custom_modules = params[:sidebar_new]["CustomModule"] if params[:sidebar_new]["CustomModule"].present?
        sidebars_tumblr_posts = params[:sidebar_new]["CacheTumblrPost"] if params[:sidebar_new]["CacheTumblrPost"].present?
        sidebars_vimeo_videos = params[:sidebar_new]["CacheVimeoVideo"] if params[:sidebar_new]["CacheVimeoVideo"].present?
        sidebars_fleakr_galleries = params[:sidebar_new]["CacheFleakrGallery"] if params[:sidebar_new]["CacheFleakrGallery"].present?
        sidebars_unique_modules = params[:sidebar_new].delete_if { |key,value| key=="CustomModule" || key=="CacheTumblrPost" || key=="CacheVimeoVideo" || key=="CacheFleakrGallery" }

        if sidebars_unique_modules
          cleaned_values = {}
          sidebars_unique_modules.each do |key, value|
            if value.include?("<p>&nbsp;</p>\r\n")
              cleaned_value = value.gsub!("<p>&nbsp;</p>\r\n","")
            else
              cleaned_value = value
            end
            cleaned_values[key] = cleaned_value
          end
          cleaned_values.each { |key, value| PageContent.create(:content => value,
                                                                :module_type => 'UniqueContentModule',
                                                                :page_id => @page.id,
                                                                :location => "sidebar",
                                                                :position => sidebars_cleaned_unique_positions[key.to_i]) }
        end

        if sidebars_custom_modules
          sidebars_custom_modules.each do |key, value|
            PageContent.create(:content => CustomModule.find(value).sidebar,
                               :module_type => 'CustomModule',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "sidebar",
                               :position => sidebars_cleaned_custom_positions[value.to_i])
          end
        end

        if sidebars_tumblr_posts
          sidebars_tumblr_posts.each do |key, value|
            PageContent.create(:content => CacheTumblrPost.find(:first, :conditions => { :tumblr_post_id => value }).desc,
                               :module_type => 'CacheTumblrPost',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "sidebar",
                               :position => sidebars_cleaned_tumblr_positions[value.to_i])
          end
        end

        if sidebars_vimeo_videos
          sidebars_vimeo_videos.each do |key, value|
            PageContent.create(:content => CacheVimeoVideo.find(:first, :conditions => { :vimeo_video_id => value }).url,
                               :module_type => 'CacheVimeoVideo',
                               :module_id => value,
                               :page_id => @page.id,
                               :location => "sidebar",
                               :position => sidebars_cleaned_vimeo_positions[value.to_i])
          end
        end

        if sidebars_fleakr_galleries
          sidebars_fleakr_galleries.each do |key, value|
            PageContent.create(:content => CacheFleakrGallery.find(:first, :conditions => { :fleakr_gallery_id => value }).title,
                                                                   :module_type => 'CacheFleakrGallery',
                                                                   :module_id => value,
                                                                   :page_id => @page.id,
                                                                   :location => "sidebar",
                                                                   :position => sidebars_cleaned_fleakr_positions[value.to_i])
          end
        end
      end

    # Update old contents

    if params[:header_contents].present?
      header_contents_now = []
      params[:header_contents].each do |key, value|
        header_content = PageContent.find(key.to_i)
        
        if header_content.module_type == 'UniqueContentModule'
          new_position = headers_cleaned_unique_positions[key.to_i]
        elsif header_content.module_type == 'CustomModule'
          new_position = headers_cleaned_custom_positions[value.to_i]
        elsif header_content.module_type == 'CacheTumblrPost'
          new_position = headers_cleaned_tumblr_positions[value.to_i]
        elsif header_content.module_type == 'CacheVimeoVideo'
          new_position = headers_cleaned_vimeo_positions[value.to_i]
        elsif header_content.module_type == 'CacheFleakrGallery'
          new_position = headers_cleaned_fleakr_positions[value.to_i]
        end

        header_content.update_attributes(:content => value, :position => new_position) if header_content
        header_contents_now << key.to_i
      end
      unusable_header_contents = header_contents_last - header_contents_now
      unusable_header_contents.each { |id| PageContent.find(id).destroy }
    else
      header_contents_last.each { |id| PageContent.find(id).destroy }
    end

    if params[:page_contents].present?
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
      page_contents_last.each { |id| PageContent.find(id).destroy }
    end

    if params[:sidebar_contents].present?
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
      sidebar_contents_last.each { |id| PageContent.find(id).destroy }
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
      page_to_navigation = PagesToNavigation.find(value['item_id'].to_i)    
      page = page_to_navigation.page
      page.update_attribute(:permalink, "undefined") if page.permalink.blank?
      if value['parent_id'].to_i > 0
        page_to_navigation.update_attributes(:position => key.to_i, :parent_id => value['parent_id'].to_i)
      else
        page_to_navigation.update_attributes(:position => key.to_i, :parent_id => 0)
      end
    end

    render :nothing => true
  end

  private

  def define_page
    @current_page = 'pages'
  end
end

