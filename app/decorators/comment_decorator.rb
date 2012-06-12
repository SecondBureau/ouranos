class CommentDecorator < ApplicationDecorator
  decorates :comment

  def self.decorate model
    @@comments_size = model.length
    super
  end

  def short_content
    if comment && comment.content
      h.truncate(comment.content, :length => 38, :omission => '... ')
    end
  end

  def created_at
    h.time_ago_in_words(comment.created_at)
  end

  def index i
    @@comments_size - i
  end

end
