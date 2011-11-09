class Ckeditor::Picture < Ckeditor::Asset
  mount_uploader :data, CkeditorPictureUploader, :mount_on => :data_file_name
  
  has_attached_file :data,
              :storage => :s3,
              :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
              :path => ":class/:id/:basename.:extension",
              :styles => {}
	
	def url_content
	  url(:content)
	end
end
