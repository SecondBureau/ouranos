class Event < ActiveRecord::Base
  
  default_scope :order => "start_date DESC"
  scope :public_events, lambda{where("event_type = ?", "for_all")}
  
  def event_type_enum
    [['for all', 'for_all'], ['for member', 'for_member']]
  end
  
end
