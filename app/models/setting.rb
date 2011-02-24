class Setting < ActiveRecord::Base
  cattr_accessor :api_key, :api_token
  validates :title, :configuration, :presence => true
end
