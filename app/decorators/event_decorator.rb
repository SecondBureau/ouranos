class EventDecorator < ApplicationDecorator
  decorates :event

  def summary
    h.raw(h.truncate(h.strip_tags(event.content), :length => 500, :omission => '...'))
  end
  
  def start_date
    event.start_date.strftime("%d/%m")
  end
  
  def short_title
    h.truncate(event.title, :length => 35, :omission => '... ')
  end
  
end
