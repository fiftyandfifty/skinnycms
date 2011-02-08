class PagesToNavigation < ActiveRecord::Base
  belongs_to :navigation
  belongs_to :page
end