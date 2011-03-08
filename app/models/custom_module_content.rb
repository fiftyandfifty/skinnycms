class CustomModuleContent < ActiveRecord::Base
  belongs_to :custom_module

  validates :custom_module_id, :location, :presence => true
end

