class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  
  default_scope :order => 'created_at DESC'
  scope :public_posts, lambda{where("post_type = ?", "for_all")}
  
  def post_type_enum
    [['for all', 'for_all'], ['for member', 'for_member']]
  end
  
end
