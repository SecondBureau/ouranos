class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  
  validates_presence_of :content
  
  default_scope :order => 'created_at DESC'
  scope :recent_comments, lambda{ limit(5) }
  
  after_save :expire_cache
  
  def author
    user.family.name if user && user.family
  end
  
  private
  
  def expire_cache
    if commentable.is_a?(Post)
      $available_locales.each do |locale|
        %w[ admin member ].each {|role| Rails.cache.delete "views/post_#{locale}_#{commentable.id}_#{role}"}
      end
    end
  end
  
  
end
