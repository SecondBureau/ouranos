Refinery::Blog::Category.class_eval do

  include ActionView::Helpers::TextHelper
  
  attr_accessible :description
  
  def short_title
    truncate(self.title, :length => 50, :omission => '... ')
  end
  
  def short_description
    truncate(self.description, :length => 70, :omission => '... ')
  end

end
