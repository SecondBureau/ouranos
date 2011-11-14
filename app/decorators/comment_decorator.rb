class CommentDecorator < ApplicationDecorator
  decorates :comment
  
  def self.decorate model
    @@comments_size = model.length
    super
  end

  def created_at
    h.time_ago_in_words(comment.created_at)
  end
  
  def index i
    @@comments_size - i
  end
  
end
