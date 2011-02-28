class Setting < ActiveRecord::Base
  cattr_accessor :api_key, :api_token
  validates :title, :configuration, :presence => true

  def self.rackspace_credentials
    rackspace_setting = where(:title => 'Rackspace Cloudfiles').first
     if rackspace_setting.present?
       {
         :container => JSON.parse(rackspace_setting.configuration)['container'],
         :username => JSON.parse(rackspace_setting.configuration)['api_token'],
         :api_key => JSON.parse(rackspace_setting.configuration)['api_key']
       }
     else
       {}
     end
  end
end
