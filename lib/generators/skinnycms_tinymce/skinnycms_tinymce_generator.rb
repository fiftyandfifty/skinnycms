require 'rails/generators'

class SkinnycmsTinymceGenerator < Rails::Generators::Base

  desc "Integrate the tinymce to application"

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  def copy_tinymce_files
    puts SkinnycmsTinymceGenerator.start_description
    sleep(3)
    
    directory "kete-tiny_mce-a8dc663", "vendor/plugins/kete-tiny_mce-a8dc663" if Dir["vendor/plugins/kete-tiny_mce-a8dc663"].blank?
    
    config_tiny_mce_file = IO.read('config/tiny_mce.yml')

    tiny_mce_configs = "theme: advanced
plugins:
  - spellchecker
  - pagebreak
  - style
  - layer
  - table
  - save
  - advhr
  - advimage
  - advlink
  - emotions
  - iespell
  - inlinepopups
  - insertdatetime
  - preview
  - media
  - searchreplace
  - print
  - contextmenu
  - paste
  - directionality
  - fullscreen
  - noneditable
  - visualchars
  - nonbreaking
  - xhtmlxtras
  - template
external_image_list_url : '/javascripts/tiny_mce/image_list.js'
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

    if config_tiny_mce_file.scan(tiny_mce_configs).size < 1
      f = File.open("#{Rails.root}/config/tiny_mce.yml",'w+')
      f.write(tiny_mce_configs)
      f.close
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