class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  
  default_scope :order => 'created_at DESC'
  scope :public_posts, lambda{where("post_type = ?", "for_all")}
  after_save :set_permalink
  
  searchable do
    text :title
    text :content
  end
  
  def post_type_enum
    [['for all', 'for_all'], ['for member', 'for_member']]
  end
  
  def to_param
    self.permalink
  end
  
private
  
  def set_permalink
    if self.permalink.nil?
      self.permalink = "#{self.title.parameterize}-#{self.id}"
      self.save
    end
  end
  
end
