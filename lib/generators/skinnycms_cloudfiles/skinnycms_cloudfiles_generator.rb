require 'rails/generators'

class SkinnycmsCloudfilesGenerator < Rails::Generators::Base

  desc "Integrate the cloudfiles to application"

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'files')
  end

  def copy_cloudfiles_files
    puts SkinnycmsCloudfilesGenerator.start_description
    sleep(3)

    if !File.exist?('config/rackspace_cloudfiles.yml')
      copy_file "rackspace_cloudfiles.yml", "config/rackspace_cloudfiles.yml"
    else
      if yes? "You already have 'config/rackspace_cloudfiles.yml' file. If you want to update it - type 'yes'. If you want to customize it manually - type 'no'!", :green
        remove_file "config/rackspace_cloudfiles.yml"
        copy_file "rackspace_cloudfiles.yml", "config/rackspace_cloudfiles.yml"
      end
    end
    
    puts SkinnycmsCloudfilesGenerator.end_description
  end

  def self.start_description
        <<-DESCRIPTION
*******************************************************************

  SKINNYCMS: Configuring cloudfiles as main storage for assets ...

*******************************************************************
        DESCRIPTION
  end

  def self.end_description
        <<-DESCRIPTION
*******************************************************************

  Cloudfiles successfully configured!

*******************************************************************
        DESCRIPTION
  end
end