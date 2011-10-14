class Event < ActiveRecord::Base
  default_scope :order => "start_date DESC"
  
  before_save :lipsum
  
  def event_type_enum
    [['for all', 'for_all'], ['for member', 'for_member']]
  end
  
  def date
    self.start_date
  end
  
  private
  
  def lipsum
    self.content  = Lipsum.generate(:words => 100 + rand(5), :start_with_lipsum => false) if self.content.eql?'lipsum'
    self.title    = Lipsum.generate(:words => 3 + rand(5), :start_with_lipsum => false) if self.title.eql?'lipsum'
    self.meta_description    = Lipsum.generate(:characters => 150 + rand(50), :start_with_lipsum => false) if self.meta_description.eql?'lipsum'
    self.meta_keywords    = Lipsum.generate(:words => 20 + rand(5), :start_with_lipsum => false).gsub('.','').gsub(',','').split(' ').join(', ') if self.meta_keywords.eql?'lipsum'
  end
  
end
