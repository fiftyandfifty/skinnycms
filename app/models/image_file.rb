class ImageFile < Asset
  has_attached_file :asset,
    :styles => {
      :medium => "300x300>",
      :small => "150x150>",
      :thumb => "40x40>",
      :bigthumb => "60x60>"
    }
end
