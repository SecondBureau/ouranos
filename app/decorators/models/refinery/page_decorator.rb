Refinery::Page.class_eval do
  
  def self.modal_notice
    (Refinery::Page.where(:menu_match => '^/$').first.content_for(:side_body) if Refinery::Page.where(:menu_match => '^/$').first) || ""
  end
  
  def self.home_contact
    #(Refinery::Page.by_slug('contact').first.content_for(:side_body) if Refinery::Page.by_slug('contact').first) || ""
    (Refinery::Page.where(:menu_match => '^/(inquiries|contact).*$').first.content_for(:home) if Refinery::Page.where(:menu_match => '^/(inquiries|contact).*$').first) || ""
  end
  
  def self.join_us
    #(Refinery::Page.by_slug('contact').first.content_for(:side_body) if Refinery::Page.by_slug('contact').first) || ""
    (Refinery::Page.where(:menu_match => '^/(inquiries|contact).*$').first.content_for(:join_us) if Refinery::Page.where(:menu_match => '^/(inquiries|contact).*$').first) || ""
  end
  
  def self.edito
    (Refinery::Page.where(:menu_match => '^/$').first.content_for(:body) if Refinery::Page.where(:menu_match => '^/$').first) || ""
  end
  
  # for cache management
  def self.latest
    unscoped.order('updated_at desc').first
  end

  def etag
    updated_at.to_i
  end
  
end