require 'rails/generators'

class SkinnycmsDbSeedsGenerator < Rails::Generators::Base

  desc "Add skinnycms's db/seeds to application"

  def copy_db_seeds
    puts SkinnycmsDbSeedsGenerator.start_description
    sleep(3)
    inject_into_file "db/seeds.rb", :before => "# This file should contain all the record creation" do
"User.create!(:name => 'fifty admin',
             :email => 'admin@fiftyandfifty.org',
             :password => 'fiftyand50',
             :password_confirmation => 'fiftyand50',
             :confirmed_at => Time.now)

[1, 2, 3, 4].each do |i|
  Page.create(:title => \"public_page_#{"i"}\",
              :permalink => \"www.ezample.com/public_page_#{"i"}\",
              :status => 'Published',
              :visibility => 'public',
              :seo_title => 'seo_title',
              :seo_description => 'seo_description',
              :seo_keywords => 'seo_keywords')
  Page.create(:title => \"private_page_#{"i"}\",
              :permalink => \"www.ezample.com/private_page_#{"i"}\",
              :status => 'Published',
              :visibility => 'private',
              :seo_title => 'seo_title',
              :seo_description => 'seo_description',
              :seo_keywords => 'seo_keywords')
end

Page.create(:title => 'public_page_5',
            :permalink => 'www.ezample.com/public_page_5',
            :status => 'Published',
            :parent_id => Page.first.id,
            :visibility => 'public',
            :seo_title => 'seo_title',
            :seo_description => 'seo_description',
            :seo_keywords => 'seo_keywords')



Page.all.each do |page|
  PageContent.create(:content => 'HEADER: Lorem ipsum dolor omet',
                    :page_id => page.id,
                    :location => 'header')
  PageContent.create(:content => 'CONTENT: Lorem ipsum dolor omet',
                    :page_id => page.id,
                    :location => 'content')
  PageContent.create(:content => 'SITEBAR: Lorem ipsum dolor omet',
                    :page_id => page.id,
                    :location => 'sitebar')
end\n\n"
    end
    run "rake db:seed"
    puts SkinnycmsDbSeedsGenerator.end_description
  end

  def self.start_description
        <<-DESCRIPTION
*******************************************************************

  SKINNYCMS( ONLY FOR TESTING ): Adding basic database seeds ...

*******************************************************************
        DESCRIPTION
  end

  def self.end_description
        <<-DESCRIPTION
*******************************************************************

  Database seeds successfully configured!

  Your test login:

    admin@fiftyandfifty.org

  Your test password:

    fiftyand50

*******************************************************************
        DESCRIPTION
  end
end