class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  
  default_scope :order => 'created_at DESC'
  scope :valid, lambda{where(:is_valid => true)}
  scope :unvalid, lambda{|user| where(:is_valid => false).where(:user_id => user.id)}
  
end
