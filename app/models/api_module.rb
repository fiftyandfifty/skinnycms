class ApiModule < ActiveRecord::Base
  cattr_accessor :api_key, :api_token
  validates :module_name, :presence => true
end
