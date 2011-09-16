class Post < ActiveRecord::Base
  
  require 'lipsum'
  
  belongs_to :user
  has_many :comments, :as => :commentable
  
  default_scope :order => 'created_at DESC'
  scope :public_posts, lambda{where("post_type = ?", "for_all")}
  before_save :lipsum
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
  
  def lipsum
    self.content  = Lipsum.generate(:words => 100 + rand(5), :start_with_lipsum => false) if self.content.eql?'lipsum'
    self.title    = Lipsum.generate(:words => 3 + rand(5), :start_with_lipsum => false) if self.title.eql?'lipsum'
    self.meta_description    = Lipsum.generate(:characters => 150 + rand(50), :start_with_lipsum => false) if self.meta_description.eql?'lipsum'
    self.meta_keywords    = Lipsum.generate(:words => 20 + rand(5), :start_with_lipsum => false).gsub('.','').gsub(',','').split(' ').join(', ') if self.meta_keywords.eql?'lipsum'
  end
  
end
