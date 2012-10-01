Refinery::Page.class_eval do
  
  def self.modal_notice
    (Refinery::Page.by_slug('home').first.content_for(:side_body) if Refinery::Page.by_slug('home').first) || ""
  end
  
  def self.home_contact
    (Refinery::Page.by_slug('contact').first.content_for(:side_body) if Refinery::Page.by_slug('contact').first) || ""
  end
  
end