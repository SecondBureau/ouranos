class Image < ActiveRecord::Base
  has_attached_file :image, :styles => { :banner_image => "620x190>", :thumb => "50x50>" }
  belongs_to :image_owner , :polymorphic => true
end
