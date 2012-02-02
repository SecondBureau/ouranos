class Page < ActiveRecord::Base
  
  require 'lipsum'
  
  scope :available, lambda { where(:locale => $available_locales)}
  scope :notme, lambda {|id| id.nil? ? where('1=1') : where('id <> ?', id)}
  
  validates_presence_of   :title, :locale, :content
  validates_uniqueness_of :permalink,  :scope => :locale
  validates_length_of     :meta_keywords,  :maximum => 200
  validates_length_of     :meta_description,  :maximum => 200
  validates_length_of     :title,  :maximum => 50
  validates_length_of     :permalink,  :maximum => 150
  
  before_validation :check_locale
  before_validation :check_permalink
  before_save :lipsum
  after_save :expire_cache
  
  private
  
  def check_permalink
    self.permalink = free_permalink
  end
  
  def free_permalink
    permalink = permalink_base = (self.permalink.blank? ?   self.title : self.permalink).parameterize
    i=1
    until Page.notme(self.id).where(:permalink => permalink, :locale => self.locale).count.eql?(0)
      permalink = "#{permalink_base}-#{i.to_s}"
      i = i.succ
    end
    permalink
  end
  
  def check_locale
    self.locale = $available_locales.first unless $available_locales.include?(self.locale)
  end
  
  def self.local_page(permalink, locale=nil)
    locale ||= I18n.locale
    page = Page.where(:permalink => permalink, :locale => locale).first
    if page.nil?
       page = Page.where(:permalink => permalink, :locale => $available_locales.first).first unless locale.eql?($available_locales.first)
    end
    page
  end
  
  def lipsum
    self.content  = lipsum_content if self.content.eql?'lipsum'
    self.title    = Lipsum.generate(:words => 3 + rand(5), :start_with_lipsum => false) if self.title.eql?'lipsum'
    self.meta_description    = Lipsum.generate(:characters => 150 + rand(50), :start_with_lipsum => false) if self.meta_description.eql?'lipsum'
    self.meta_keywords    = Lipsum.generate(:words => 20 + rand(5), :start_with_lipsum => false).gsub('.','').gsub(',','').split(' ').join(', ') if self.meta_keywords.eql?'lipsum'
  end
  
  def lipsum_title
    Lipsum.generate(:words => 3 + rand(5), :start_with_lipsum => false)
  end
  
  def lipsum_body_part
    Lipsum.generate(:words => 300 + rand(50), :start_with_lipsum => false)
  end
  
  def lipsum_content
    content = ''
    (1..(1+rand(3))).each { |i| content = "#{content}<h2>#{lipsum_title}</h2><p>#{lipsum_body_part}</p>"}
    content
  end
  
  def expire_cache
    def expire_cache
      $available_locales.each do |locale|
        day = (Time.now.utc.in_time_zone("Beijing")).strftime("%Y%m%d")
        %w[ header sidebar ].each {|page| Rails.cache.delete "views/#{page}_#{locale}_#{day}"}
      end
      Rails.cache.delete "views/page_#{self.locale}_#{self.id}"
    end
  end

end
