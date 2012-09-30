Refinery::Page.class_eval do
  
  def self.modal_notice
    Refinery::Page.by_slug('home').first.content_for(:side_body) if Refinery::Page.by_slug('home').first
  end
  
end