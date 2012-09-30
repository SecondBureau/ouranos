Refinery::Blog::Comment.class_eval do
  
  include ActionView::Helpers::TextHelper
  
  def short_body
    truncate(self.body, :length => 80, :omission => '... ')
  end
  
  def self.recent(count)
    approved.order('updated_at desc').limit(count)
  end

end
