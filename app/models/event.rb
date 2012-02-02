class Event < ActiveRecord::Base
  before_save :lipsum
  validates_presence_of :title, :content, :start_date
  after_save :expire_cache
  
  scope :comming_events, lambda{ where("start_date >= ?", DateTime.now).order('start_date asc').limit(5) }
  
  class << self
    
    def years
      all.group_by{ |event| event.start_date.year }.keys
    end
    
    def year_events year
      order("start_date ASC").select{|event| event.start_date.year == year }
    end
    
    def group_by_month_in_a_year year
      year_events(year).group_by { |event| event.start_date.month }
    end
    
  end
  
  private
  
  def lipsum
    self.content  = Lipsum.generate(:words => 100 + rand(5), :start_with_lipsum => false) if self.content.eql?'lipsum'
    self.title    = Lipsum.generate(:words => 3 + rand(5), :start_with_lipsum => false) if self.title.eql?'lipsum'
    self.meta_description    = Lipsum.generate(:characters => 150 + rand(50), :start_with_lipsum => false) if self.meta_description.eql?'lipsum'
    self.meta_keywords    = Lipsum.generate(:words => 20 + rand(5), :start_with_lipsum => false).gsub('.','').gsub(',','').split(' ').join(', ') if self.meta_keywords.eql?'lipsum'
  end
  
  def expire_cache
    $available_locales.each do |locale|
      day = (Time.now.utc.in_time_zone("Beijing")).strftime("%Y%m%d")
      %w[ header sidebar ].each {|page| Rails.cache.delete "views/#{page}_#{locale}_#{day}"}
    end
  end
  
end
