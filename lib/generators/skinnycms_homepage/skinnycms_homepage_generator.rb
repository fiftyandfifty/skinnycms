require 'rails/generators'

class SkinnycmsHomepageGenerator < Rails::Generators::Base

  desc "Generate homepage to application"

  def integrate_homepage
    puts SkinnycmsHomepageGenerator.start_description
    sleep(3)

    if yes? "This is default homepage generator, which will create default homepage in your application. If you already have homepage you can skip this generator! Do you want to create it now?", :green

      Page.create!(:title => 'Home',
                   :permalink => '/home',
                   :seo_title => 'home',
                   :seo_description => 'home page',
                   :seo_keywords => 'home, page, default',
                   :template_id => Template.find(:first, :conditions => { :title => 'Home Page' }))

      PagesToNavigation.create!(:navigation_id => Navigation.find(:first, :conditions => { :title => 'main_navigation' }),
                                :page_id => Page.find(:first, :conditions => { :title => 'Home' }).id)

      PageContent.create!(:page_id => Page.find(:first, :conditions => { :title => 'Home' }).id,
                          :content => 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                          :location => 'header')

      PageContent.create!(:page_id => Page.find(:first, :conditions => { :title => 'Home' }).id,
                          :content => 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum comes from a line in section 1.10.32.',
                          :location => 'content')

      PageContent.create!(:page_id => Page.find(:first, :conditions => { :title => 'Home' }).id,
                          :content => 'The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.',
                          :location => 'sidebar')

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