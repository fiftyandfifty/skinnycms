require 'rails/generators'

class SkinnycmsHomepageGenerator < Rails::Generators::Base

  desc "Generate homepage to application"

  def self.source_root
      @source_root ||= File.dirname(__FILE__)
  end

  def integrate_homepage
    puts SkinnycmsHomepageGenerator.start_description
    sleep(3)

    if yes? "This is default homepage generator, which will create default homepage in your application. If you already have homepage you can skip this generator! Do you want to create it now?", :green

      Navigation.create!(:title => 'Main Navigation')
      Navigation.create!(:title => 'Secondary Navigation')
      Navigation.create!(:title => 'Footer Navigation')
      
      main_navigation_id = Navigation.find(:first, :conditions => { :title => 'Main Navigation' }).id
      secondary_navigation_id = Navigation.find(:first, :conditions => { :title => 'Secondary Navigation' }).id
      footer_navigation_id = Navigation.find(:first, :conditions => { :title => 'Footer Navigation' }).id

      Template.create!(:title => 'Home Page', :content_locations => 'header,content,sidebar')
      Template.create!(:title => 'Landing Page', :content_locations => 'header,content,sidebar')
      Template.create!(:title => 'Detail Page', :content_locations => 'header,content,sidebar')

      home_page_template_id = Template.find(:first, :conditions => { :title => 'Home Page' }).id
      landing_page_template_id = Template.find(:first, :conditions => { :title => 'Landing Page' }).id
      detail_page_template_id = Template.find(:first, :conditions => { :title => 'Detail Page' }).id  

      Page.create!(:title => 'Home',
                    :permalink => 'home',
                    :status => 'published',
                    :template_id => home_page_template_id)
                    
      Page.create!(:title => 'About Us',
                    :permalink => 'about-us',
                    :status => 'published',
                    :template_id => landing_page_template_id)
                    
      Page.create!(:title => 'History',
                    :permalink => 'history',
                    :status => 'published',
                    :template_id => detail_page_template_id)
                    
      Page.create!(:title => 'Sign In',
                    :permalink => 'sign-in',
                    :status => 'published',
                    :redirect_url => '/admin')

      home_page_id = Page.find(:first, :conditions => { :title => 'Home' }).id
      sign_in_page_id = Page.find(:first, :conditions => { :title => 'Sign In' }).id
      about_us_page_id = Page.find(:first, :conditions => { :title => 'About Us' }).id
      history_page_id = Page.find(:first, :conditions => { :title => 'History' }).id
      
      PagesToNavigation.create!(:page_id => home_page_id, :navigation_id => main_navigation_id, :parent_id => 0, :position => 0)
      PagesToNavigation.create!(:page_id => home_page_id, :navigation_id => footer_navigation_id, :parent_id => 0, :position => 0)

      PagesToNavigation.create!(:page_id => sign_in_page_id, :navigation_id => secondary_navigation_id, :parent_id => 0, :position => 1)
      
      PagesToNavigation.create!(:page_id => about_us_page_id, :navigation_id => main_navigation_id, :parent_id => 0, :position => 2)
      PagesToNavigation.create!(:page_id => about_us_page_id, :navigation_id => footer_navigation_id, :parent_id => 0, :position => 2)

      about_us_main_nav_id = PagesToNavigation.find(:first, :conditions => { :page_id => about_us_page_id, :navigation_id => main_navigation_id }).id
      about_us_footer_nav_id = PagesToNavigation.find(:first, :conditions => { :page_id => about_us_page_id, :navigation_id => footer_navigation_id }).id
      
      PagesToNavigation.create!(:page_id => history_page_id, :navigation_id => main_navigation_id, :parent_id => about_us_main_nav_id, :position => 1)
      PagesToNavigation.create!(:page_id => history_page_id, :navigation_id => footer_navigation_id, :parent_id => about_us_footer_nav_id, :position => 1)
            
      PageContent.create!(:page_id => home_page_id,
                          :content => '<p><h2>Welcome to your new website!</h2></p>',
                          :location => 'header')
      PageContent.create!(:page_id => home_page_id,
                          :content => '<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum comes from a line in section 1.10.32.</p><p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>',
                          :location => 'content')
      PageContent.create!(:page_id => home_page_id,
                          :content => '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',
                          :location => 'sidebar')
                          
      PageContent.create!(:page_id => about_us_page_id,
                          :content => '<p><h1>About Us</h1></p>',
                          :location => 'header')
      PageContent.create!(:page_id => about_us_page_id,
                          :content => '<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum comes from a line in section 1.10.32.</p><p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>',
                          :location => 'content')
      PageContent.create!(:page_id => about_us_page_id,
                          :content => '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',
                          :location => 'sidebar')
                          
      PageContent.create!(:page_id => history_page_id,
                          :content => '<p><h1>Our History</h1></p>',
                          :location => 'header')
      PageContent.create!(:page_id => history_page_id,
                          :content => '<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum comes from a line in section 1.10.32.</p><p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>',
                          :location => 'content')
      PageContent.create!(:page_id => history_page_id,
                          :content => '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',
                          :location => 'sidebar')
                                
      User.create!(:name => '5ifty 5ifty Admin',
                   :email => 'admin@fiftyandfifty.org',
                   :password => 'fiftyand50',
                   :password_confirmation => 'fiftyand50',
                   :confirmed_at => Time.now)
                   
      if !File.exist?('app/helpers/page_helper.rb')
        copy_file "page_helper.rb", "app/helpers/page_helper.rb"
      else
        if yes? "You already have 'app/helpers/page_helper.rb' helper. Do you want to update it?", :green
          remove_file "app/helpers/page_helper.rb"
          copy_file "page_helper.rb", "app/helpers/page_helper.rb"
        end
      end

    end

    puts SkinnycmsHomepageGenerator.end_description
  end

  def self.start_description
        <<-DESCRIPTION
*******************************************************************

  SKINNYCMS: Generate default homepage ...

*******************************************************************
        DESCRIPTION
  end

  def self.end_description
        <<-DESCRIPTION
*******************************************************************

  Homepage successfully generated!

*******************************************************************
        DESCRIPTION
  end
end