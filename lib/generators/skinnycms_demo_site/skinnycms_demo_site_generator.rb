require 'rails/generators'

class SkinnycmsDemoSiteGenerator < Rails::Generators::Base

  desc "Generate a SkinnyCMS Demo Site"

  def self.source_root
      @source_root ||= File.dirname(__FILE__)
  end

  def install
    puts SkinnycmsDemoSiteGenerator.start_description
    sleep(3)

    if yes? "This is demo site generator, which will create 3 page templates, 4 demo pages & 3 dynamic navigations. If you already have a working site you can skip this generator! Do you want to run it now?", :green

      Navigation.new(:title => 'Main Navigation').save
      Navigation.new(:title => 'Secondary Navigation').save
      Navigation.new(:title => 'Footer Navigation').save
      
      main_navigation_id = Navigation.find(:first, :conditions => { :title => 'Main Navigation' }).id
      secondary_navigation_id = Navigation.find(:first, :conditions => { :title => 'Secondary Navigation' }).id
      footer_navigation_id = Navigation.find(:first, :conditions => { :title => 'Footer Navigation' }).id

      Template.new(:title => 'Home Page', :content_locations => 'header,content,sidebar').save
      Template.new(:title => 'Landing Page', :content_locations => 'header,content,sidebar').save
      Template.new(:title => 'Detail Page', :content_locations => 'header,content,sidebar').save

      home_page_template_id = Template.find(:first, :conditions => { :title => 'Home Page' }).id
      landing_page_template_id = Template.find(:first, :conditions => { :title => 'Landing Page' }).id
      detail_page_template_id = Template.find(:first, :conditions => { :title => 'Detail Page' }).id  

      Page.new(:title => 'Home',
                    :permalink => 'home',
                    :status => 'published',
                    :template_id => home_page_template_id).save
                    
      Page.new(:title => 'About Us',
                    :permalink => 'about-us',
                    :status => 'published',
                    :template_id => landing_page_template_id).save
                    
      Page.new(:title => 'History',
                    :permalink => 'history',
                    :status => 'published',
                    :template_id => detail_page_template_id).save
                    
      Page.new(:title => 'Sign In',
                    :permalink => 'sign-in',
                    :status => 'published',
                    :redirect_url => '/admin').save

      home_page_id = Page.find(:first, :conditions => { :title => 'Home' }).id
      sign_in_page_id = Page.find(:first, :conditions => { :title => 'Sign In' }).id
      about_us_page_id = Page.find(:first, :conditions => { :title => 'About Us' }).id
      history_page_id = Page.find(:first, :conditions => { :title => 'History' }).id
      
      PagesToNavigation.new(:page_id => home_page_id, :navigation_id => main_navigation_id, :parent_id => 0, :position => 0).save
      PagesToNavigation.new(:page_id => home_page_id, :navigation_id => footer_navigation_id, :parent_id => 0, :position => 0).save

      PagesToNavigation.new(:page_id => sign_in_page_id, :navigation_id => secondary_navigation_id, :parent_id => 0, :position => 1).save
      
      PagesToNavigation.new(:page_id => about_us_page_id, :navigation_id => main_navigation_id, :parent_id => 0, :position => 2).save
      PagesToNavigation.new(:page_id => about_us_page_id, :navigation_id => footer_navigation_id, :parent_id => 0, :position => 2).save

      about_us_main_nav_id = PagesToNavigation.find(:first, :conditions => { :page_id => about_us_page_id, :navigation_id => main_navigation_id }).id
      about_us_footer_nav_id = PagesToNavigation.find(:first, :conditions => { :page_id => about_us_page_id, :navigation_id => footer_navigation_id }).id
      
      PagesToNavigation.new(:page_id => history_page_id, :navigation_id => main_navigation_id, :parent_id => about_us_main_nav_id, :position => 1).save
      PagesToNavigation.new(:page_id => history_page_id, :navigation_id => footer_navigation_id, :parent_id => about_us_footer_nav_id, :position => 1).save
            
      PageContent.new(:page_id => home_page_id,
                          :content => '<p><h2>Welcome to your new website!</h2></p>',
                          :location => 'header',
                          :module_type => 'UniqueContentModule').save
      PageContent.new(:page_id => home_page_id,
                          :content => '<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum comes from a line in section 1.10.32.</p><p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>',
                          :location => 'content',
                          :module_type => 'UniqueContentModule').save
      PageContent.new(:page_id => home_page_id,
                          :content => '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',
                          :location => 'sidebar',
                          :module_type => 'UniqueContentModule').save
                          
      PageContent.new(:page_id => about_us_page_id,
                          :content => '<p><h1>About Us</h1></p>',
                          :location => 'header',
                          :module_type => 'UniqueContentModule').save
      PageContent.new(:page_id => about_us_page_id,
                          :content => '<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum comes from a line in section 1.10.32.</p><p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>',
                          :location => 'content',
                          :module_type => 'UniqueContentModule').save
      PageContent.new(:page_id => about_us_page_id,
                          :content => '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',
                          :location => 'sidebar',
                          :module_type => 'UniqueContentModule').save
                          
      PageContent.new(:page_id => history_page_id,
                          :content => '<p><h1>Our History</h1></p>',
                          :location => 'header',
                          :module_type => 'UniqueContentModule').save
      PageContent.new(:page_id => history_page_id,
                          :content => '<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum comes from a line in section 1.10.32.</p><p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>',
                          :location => 'content',
                          :module_type => 'UniqueContentModule').save
      PageContent.new(:page_id => history_page_id,
                          :content => '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',
                          :location => 'sidebar',
                          :module_type => 'UniqueContentModule').save
                                
      User.new(:name => '5ifty 5ifty Admin',
                   :email => 'admin@fiftyandfifty.org',
                   :password => 'fiftyand50',
                   :password_confirmation => 'fiftyand50',
                   :confirmed_at => Time.now).save
                   
      if !File.exist?('app/helpers/page_helper.rb')
        copy_file "page_helper.rb", "app/helpers/page_helper.rb"
      else
        if yes? "You already have 'app/helpers/page_helper.rb' helper. Do you want to update it?", :green
          remove_file "app/helpers/page_helper.rb"
          copy_file "page_helper.rb", "app/helpers/page_helper.rb"
        end
      end
      
      if !File.exist?('app/views/layouts/home_page.html.erb')
        copy_file "home_page.html.erb", "app/views/layouts/home_page.html.erb"
      else
        if yes? "You already have 'app/views/layouts/home_page.html.erb' layout. Do you want to update it?", :green
          remove_file "app/views/layouts/home_page.html.erb"
          copy_file "home_page.html.erb", "app/views/layouts/home_page.html.erb"
        end
      end
    
      if !File.exist?('app/views/layouts/landing_page.html.erb')
        copy_file "landing_page.html.erb", "app/views/layouts/landing_page.html.erb"
      else
        if yes? "You already have 'app/views/layouts/landing_page.html.erb' layout. Do you want to update it?", :green
          remove_file "app/views/layouts/landing_page.html.erb"
          copy_file "landing_page.html.erb", "app/views/layouts/landing_page.html.erb"
        end
      end
    
      if !File.exist?('app/views/layouts/detail_page.html.erb')
        copy_file "detail_page.html.erb", "app/views/layouts/detail_page.html.erb"
      else
        if yes? "You already have 'app/views/layouts/detail_page.html.erb' layout. Do you want to update it?", :green
          remove_file "app/views/layouts/detail_page.html.erb"
          copy_file "detail_page.html.erb", "app/views/layouts/detail_page.html.erb"
        end
      end
      
      Dir.mkdir("app/views/shared") if Dir["app/views/shared"].blank?
    
      if !File.exist?('app/views/shared/_main_navigation.html.erb')
        copy_file "_main_navigation.html.erb", "app/views/shared/_main_navigation.html.erb"
      else
        if yes? "You already have 'app/views/shared/_main_navigation.html.erb' layout. Do you want to update it?", :green
          remove_file "app/views/shared/_main_navigation.html.erb"
          copy_file "_main_navigation.html.erb", "app/views/shared/_main_navigation.html.erb"
        end
      end
    
      if !File.exist?('app/views/shared/_secondary_navigation.html.erb')
        copy_file "_secondary_navigation.html.erb", "app/views/shared/_secondary_navigation.html.erb"
      else
        if yes? "You already have 'app/views/shared/_secondary_navigation.html.erb' layout. Do you want to update it?", :green
          remove_file "app/views/shared/_secondary_navigation.html.erb"
          copy_file "_secondary_navigation.html.erb", "app/views/shared/_secondary_navigation.html.erb"
        end
      end
    
      if !File.exist?('app/views/shared/_footer_navigation.html.erb')
        copy_file "_footer_navigation.html.erb", "app/views/shared/_footer_navigation.html.erb"
      else
        if yes? "You already have 'app/views/shared/_footer_navigation.html.erb' layout. Do you want to update it?", :green
          remove_file "app/views/shared/_footer_navigation.html.erb"
          copy_file "_footer_navigation.html.erb", "app/views/shared/_footer_navigation.html.erb"
        end
      end
      
      if !File.exist?('app/views/shared/_html_top.html.erb')
        copy_file "_html_top.html.erb", "app/views/shared/_html_top.html.erb"
      else
        if yes? "You already have 'app/views/shared/_html_top.html.erb' layout. Do you want to update it?", :green
          remove_file "app/views/shared/_html_top.html.erb"
          copy_file "_html_top.html.erb", "app/views/shared/_html_top.html.erb"
        end
      end
      
      if !File.exist?('app/views/shared/_page_meta.html.erb')
        copy_file "_page_meta.html.erb", "app/views/shared/_page_meta.html.erb"
      else
        if yes? "You already have 'app/views/shared/_page_meta.html.erb' layout. Do you want to update it?", :green
          remove_file "app/views/shared/_page_meta.html.erb"
          copy_file "_page_meta.html.erb", "app/views/shared/_page_meta.html.erb"
        end
      end

    end
               
    insert_into_file "config/environments/development.rb", "\n  config.action_view.javascript_expansions[:defaults] = %w(jquery rails)\n\n", :after => "::Application.configure do\n" if IO.read('config/environments/development.rb').scan("config.action_view.javascript_expansions[:defaults] = %w(jquery rails)").size < 1
    insert_into_file "config/environments/production.rb", "\n  config.action_view.javascript_expansions[:defaults] = %w(jquery rails)\n\n", :after => "::Application.configure do\n" if IO.read('config/environments/production.rb').scan("config.action_view.javascript_expansions[:defaults] = %w(jquery rails)").size < 1
    insert_into_file "config/environments/test.rb", "\n  config.action_view.javascript_expansions[:defaults] = %w(jquery rails)\n\n", :after => "::Application.configure do\n" if IO.read('config/environments/test.rb').scan("config.action_view.javascript_expansions[:defaults] = %w(jquery rails)").size < 1
    
    # remove prototype js files & configure jquery as default js
    run "rails g jquery:install"
    
    run "rake friendly_id:redo_slugs MODEL=Page"

    puts SkinnycmsDemoSiteGenerator.end_description
  end

  def self.start_description
        <<-DESCRIPTION
*******************************************************************

  SKINNYCMS: Generate demo site files ...

*******************************************************************
        DESCRIPTION
  end

  def self.end_description
        <<-DESCRIPTION
*******************************************************************

  Demo site files were successfully generated!

*******************************************************************
        DESCRIPTION
  end
end