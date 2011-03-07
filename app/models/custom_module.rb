class CustomModule < ActiveRecord::Base

  validates :title, :presence => true

  def unique_id
    id
  end
end
