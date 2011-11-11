
require 'aws/s3'
AWS::S3::DEFAULT_HOST.replace "s3-ap-northeast-1.amazonaws.com"

Paperclip.interpolates(:s3_ap_northeast_url) do |att, style|
    "#{att.s3_protocol}://s3-ap-northeast-1.amazonaws.com/#{att.bucket_name}/#{att.path(style)}"
end

