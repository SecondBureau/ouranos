class Image < ActiveRecord::Base
  has_attached_file :image, :styles => { :banner_image => "620x190>", :thumb => "50x50>" },
    :storage => :s3,
    :bucket => $s3_bucket ,
    :url => ":s3_ap-northeast_url"
    :s3_credentials => {
      :access_key_id => $s3_access_key_id  ,
      :secret_access_key => $s3_secret_access_key
    }
  belongs_to :image_owner , :polymorphic => true
end

