class Image < ActiveRecord::Base
  has_attached_file :image, :styles => { :banner_image => "620x190>", :thumb => "50x50>" },
    :storage => :s3,
    :bucket => "jzwhdemo" ,
    :s3_credentials => {
      :access_key_id => "AKIAJ6DZNIC4O23W6MJA" ,
      :secret_access_key => "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"
    }
  belongs_to :image_owner , :polymorphic => true
end
