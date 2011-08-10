class Comment < ActiveRecord::Base
  
  belongs_to :post
  
  scope :valid, lambda{ where('is_valid = 1').order("created_at DESC") }
  scope :has_unvalid_commented, lambda{ |user| where("user_id = ? and is_valid = 0", user.id)}
  
  validates_length_of :content, :minimum => 10

  
end
