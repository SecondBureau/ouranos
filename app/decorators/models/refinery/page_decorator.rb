Refinery::Page.class_eval do
  
  def self.modal_notice
    (Refinery::Page.where(:menu_match => '^/$').first.content_for(:side_body) if Refinery::Page.where(:menu_match => '^/$').first) || ""
  end
  
  def self.home_contact
    (Refinery::Page.by_slug('contact').first.content_for(:side_body) if Refinery::Page.by_slug('contact').first) || ""
  end
  
end