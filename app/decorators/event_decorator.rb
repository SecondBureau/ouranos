class EventDecorator < ApplicationDecorator
  decorates :event

  def summary
    h.raw(h.truncate(h.strip_tags(event.content), :length => 500, :omission => '...'))
  end
  
  def start_date
    event.start_date.strftime("%d/%m")
  end
  
  def date_range
    if !event.end_date
      event.start_date
    else
      h.raw("#{event.start_date} ~ #{event.end_date}")
    end
  end
  
  def short_title
    h.truncate(event.title, :length => 35, :omission => '... ')
  end
  
end
