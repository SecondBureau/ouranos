Refinery::Blog::Post.class_eval do
  
  include ActionView::Helpers::TextHelper
  
  attr_accessible :public

  def migrate_access_count(count)
    self.access_count = count
  end
  
  def short_title
    truncate(self.title, :length => 50, :omission => '... ')
  end
  
  def self.popular(count)
    unscoped.live.order("access_count * access_count / ((current_date::date - published_at::date)+1) desc").limit(count)
  end
  
  # for cache management
  def self.latest
    unscoped.live.order('updated_at desc').first
  end

  def etag
    updated_at.to_i
  end

end
