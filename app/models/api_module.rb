class ApiModule < ActiveRecord::Base

  validates :module_name,
            :api_token,
            :api_key,
            :presence => true
end
