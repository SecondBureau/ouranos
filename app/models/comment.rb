class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  
  validates_presence_of :content
  
  default_scope :order => 'created_at DESC'
  scope :recent_comments, lambda{ limit(5) }
  
end
