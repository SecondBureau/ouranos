class Event < ActiveRecord::Base
  before_save :lipsum
  validates_presence_of :title, :content, :start_date
  
  scope :comming_events, lambda{ where("start_date >= ?", DateTime.now).limit(5) }
  
  private
  
  def lipsum
    self.content  = Lipsum.generate(:words => 100 + rand(5), :start_with_lipsum => false) if self.content.eql?'lipsum'
    self.title    = Lipsum.generate(:words => 3 + rand(5), :start_with_lipsum => false) if self.title.eql?'lipsum'
    self.meta_description    = Lipsum.generate(:characters => 150 + rand(50), :start_with_lipsum => false) if self.meta_description.eql?'lipsum'
    self.meta_keywords    = Lipsum.generate(:words => 20 + rand(5), :start_with_lipsum => false).gsub('.','').gsub(',','').split(' ').join(', ') if self.meta_keywords.eql?'lipsum'
  end
  
end
