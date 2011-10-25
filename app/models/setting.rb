class Setting < ActiveRecord::Base
  has_many :images , :class_name => "Image" , :as => "image_owner" , :dependent => :destroy
end
