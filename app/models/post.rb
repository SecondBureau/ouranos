class Post < ActiveRecord::Base
  
  default_scope order('created_at')
  
  scope :public_posts, lambda{ where("post_type = 'public'") }
  
  belongs_to :user
  has_many :comments
  
end
