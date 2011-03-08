class CustomModule < ActiveRecord::Base
  has_many :custom_module_contents, :dependent => :destroy

  validates :title, :presence => true

  def unique_id
    id
  end

  def all_contents
    exist_locations = {}
    custom_module_contents.each { |c| exist_locations[c.location] = c }
    Template.all_locations.merge(exist_locations)
  end
end

