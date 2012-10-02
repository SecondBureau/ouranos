# encoding: utf-8
module Refinery
  module Calendar
    module EventsHelper
      
      def format_start_end(event, day=Time.now)
        if event.end_at.nil?
          if event.start_at.strftime('%Y%m%d').eql?(day.strftime('%Y%m%d'))
            if event.start_at.hour < 2 # means meaningless time
              ::I18n.translate('events.unknown_time')
            else
              event.start_at.strftime('%H:%M')
            end
          else
            ::I18n.localize(event.start_at, :format => :datetime)
          end
        else
          if event.start_at.strftime('%Y%m%d').eql?(event.end_at.strftime('%Y%m%d'))
            if event.start_at.strftime('%Y%m%d').eql?(day.strftime('%Y%m%d'))
              "de #{event.start_at.strftime('%H:%M')} à #{event.end_at.strftime('%H:%M')}"
            else
              "#{::I18n.localize(event.start_at, :format => "%e %B %Y")} de #{event.start_at.strftime('%H:%M')} à #{event.end_at.strftime('%H:%M')}"
            end
          else
            "#{::I18n.translate('events.from')} #{::I18n.localize(event.start_at, :format => ((event.start_at.hour < 2) ? :event : :datetime))} #{::I18n.translate('events.to')} #{::I18n.localize(event.end_at, :format => ((event.start_at.hour < 2) ? :event : :datetime))}"
          end
        end

      end
    end
  end
end



