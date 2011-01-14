require 'rails/generators'

class SkinnycmsTinymceGenerator < Rails::Generators::Base

  desc "Integrate the tinymce to application"

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  def copy_tinymce_files
    puts SkinnycmsTinymceGenerator.start_description
    sleep(3)
    directory "kete-tiny_mce-a8dc663", "vendor/plugins/kete-tiny_mce-a8dc663"
    inject_into_file "config/tiny_mce.yml", :before => "# Here you can specify default options" do
"theme: advanced
convert_urls: false
relative_urls: false
theme_advanced_resizing: true
theme_advanced_toolbar_location: top
theme_advanced_buttons1:
  - formatselect
  - bold
  - italic
  - underline
  - strikethrough
  - separator
  - justifyleft
  - justifycenter
  - justifyright
  - justifyfull
  - separator
  - bullist
  - numlist
  - separator
  - outdent
  - indent
  - separator
  - link
  - unlink
  - image
  - code
theme_advanced_buttons2: ''
theme_advanced_buttons3: ''\n"
    end
    puts SkinnycmsTinymceGenerator.end_description
  end

  def self.start_description
        <<-DESCRIPTION
*******************************************************************

  SKINNYCMS: Configuring tinymce ...

*******************************************************************
        DESCRIPTION
  end

  def self.end_description
        <<-DESCRIPTION
*******************************************************************

  Tinymce successfully configured!

*******************************************************************
        DESCRIPTION
  end
end