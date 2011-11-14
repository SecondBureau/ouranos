class Resource < ActiveRecord::Base
  
  has_attached_file :resource,
    :storage => :s3,
    :bucket => $s3_bucket ,
    :url  => ":s3_ap_northeast_url",
    :path => "resource/:id/:style.:extension",
    :s3_credentials => {
      :access_key_id => $s3_access_key_id  ,
      :secret_access_key => $s3_secret_access_key
    }
  
end
