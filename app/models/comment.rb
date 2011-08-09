class Comment < ActiveRecord::Base
  
  belongs_to :post
  
  scope :valid, lambda{ where('is_valid = 1').order("created_at DESC") }
  
end
