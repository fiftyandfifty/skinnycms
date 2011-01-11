class ApiModule < ActiveRecord::Base

  validates :module_name,
            :api_user,
            :api_password,
            :api_token,
            :api_key,
            :presence => true
end
