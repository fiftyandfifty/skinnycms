class Image < ActiveRecord::Base  
  has_attached_file :image, :styles => { :large => "905>", :medium => "605>", :small => "220>", :thumbnail =>"85>" }
end
