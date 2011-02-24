class Setting < ActiveRecord::Base
  cattr_accessor :api_key, :api_token
  validates :title, :configuration, :presence => true

  def define_cloudfiles_configuration
    new_container = JSON.parse(configuration)["container"]
    new_username = JSON.parse(configuration)["api_token"]
    new_api_key = JSON.parse(configuration)["api_key"]

    new_cloudfiles_configs = "development:
  container: #{new_container}
  username: #{new_username}
  api_key: #{new_api_key}

test:
  container: #{new_container}
  username: #{new_username}
  api_key: #{new_api_key}

production:
  container: #{new_container}
  username: #{new_username}
  api_key: #{new_api_key}
"
    cloudfiles_config_file = File.open('config/rackspace_cloudfiles.yml',"w")
    cloudfiles_config_file.write(new_cloudfiles_configs)
    cloudfiles_config_file.close
  end
end
