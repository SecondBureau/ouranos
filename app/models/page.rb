class Page < ActiveRecord::Base
  
   scope :available, lambda { where(:locale => $available_locales)}
  scope :notme, lambda {|id| id.nil? ? where('1=1') : where('id <> ?', id)}
  
   
  private
  
    
  def self.local_page(permalink, locale=nil)
    locale ||= I18n.locale
    page = Page.where(:permalink => permalink, :locale => locale).first
    if page.nil?
       page = Page.where(:permalink => permalink, :locale => $available_locales.first).first unless locale.eql?($available_locales.first)
    end
    page
  end
  
  
end
