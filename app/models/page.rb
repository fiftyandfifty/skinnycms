class Page < ActiveRecord::Base
  cattr_accessor :parent_id
  cattr_accessor :navigation

  has_many :page_contents, :dependent => :destroy
  has_many :pages_to_navigations, :dependent => :destroy
  has_many :navigations, :through  => :pages_to_navigations
  belongs_to :template

  validates :title, :permalink, :presence => true
  
  validates_uniqueness_of :title, :permalink

  has_friendly_id :title_or_permalink, :use_slug => true, :approximate_ascii => true

  scope :not_on_nav, :conditions => 'pages_to_navigations.navigation_id IS NULL' , :order => :title, :include => :pages_to_navigations

  CONTENT_TYPES = ['UniqueContentModule','CustomModule','ApiModule','CacheTumblrPost','CacheFleakrGallery','CacheVimeoVideo']

  def title_or_permalink
    if !permalink.blank?
      permalink
    else
      title
    end
  end
  
  def get_home_page_id
    page = Page.find_by_title('Home')
    page = Page.first() if !page.id
    page.id
  end

  def parent_in_navigation(navigation_name)
    pages_to_navigations.find(:first, :conditions => { :navigation_id => Navigation.find(:first, :conditions => { :title => navigation_name }).id }).parent_id rescue 0
    # TODO: fix the rescue above
  end

  def parent_id_in_navigation(navigation_name)
    parent = parent_in_navigation(navigation_name)
    return {} if parent.blank? || parent == 0
    PagesToNavigation.find(parent).page.id
  end

  def parent_title_in_navigation(navigation_name)
    parent = parent_in_navigation(navigation_name)
    return "Not on #{navigation_name}" if parent.blank? || parent == 0
    PagesToNavigation.find(parent).page.title
  end

  def this_navigation(navigation_name)
    this_nav = pages_to_navigations.first(:conditions => { :navigation_id => Navigation.find(:first, :conditions => { :title => navigation_name }).id })
    this_nav = PagesToNavigation.new if this_nav.blank?
    return this_nav
  end

  def exist_in_navigation?(navigation_name)
    navigations.where(:title => navigation_name).present?
  end

  def locations
    content_in_locations = {}
    locations = template.content_locations.split(',')
    locations.each do |loc|
     content_in_locations[loc] = PageContent.find(:all, :conditions => { :page_id => self, :location => loc }, :order => :position )
    end
    content_in_locations
  end

  def exist_and_other_locations
    Template.all_locations.merge(locations)
  end

  def define_contents(location, positions, values)
    CONTENT_TYPES.each do |type|
      positions.each_with_index do |item, index|
        if item.include?(type)
          if type.eql?('UniqueContentModule')
            content = values[type][item.sub(type,"")]
            content = content.gsub!("<p>&nbsp;</p>\r\n","") if content.include?("<p>&nbsp;</p>\r\n")
          end
          PageContent.create(:page_id => id,
                             :content => content,
                             :position => index,
                             :location => location,
                             :module_type => type,
                             :module_id => item.sub(type,"").to_i)
        end
      end
    end
  end
end

