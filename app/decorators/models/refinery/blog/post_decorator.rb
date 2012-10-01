Refinery::Blog::Post.class_eval do
  
  include ActionView::Helpers::TextHelper

  def migrate_access_count(count)
    self.access_count = count
  end
  
  def short_title
    truncate(self.title, :length => 50, :omission => '... ')
  end
  
  def self.popular(count)
    unscoped.live.order("access_count * access_count / ((current_date::date - published_at::date)+1) desc").limit(count)
  end

end
