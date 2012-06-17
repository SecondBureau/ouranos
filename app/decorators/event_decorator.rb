class EventDecorator < ApplicationDecorator
  decorates :event

  def summary
    h.raw(h.truncate(h.strip_tags(event.content), :length => 500, :omission => '...'))
  end
  
  def start_date
    event.start_date.strftime("%d/%m")
  end
  
  def date_range(options={})
    date_format = options[:format] || :default
    if !event.end_date
      I18n.l(event.start_date, :format => date_format)
    else
      h.raw("#{I18n.l(event.start_date, :format => date_format)} ~ #{I18n.l(event.end_date, :format => date_format)}")
    end
  end
  
  def short_title
    h.truncate(event.title, :length => 35, :omission => '... ')
  end
  
end
