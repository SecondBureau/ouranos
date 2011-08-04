class Post < ActiveRecord::Base
  
  default_scope order('created_at')
  
  belongs_to :user
  has_many :comments
  
end
