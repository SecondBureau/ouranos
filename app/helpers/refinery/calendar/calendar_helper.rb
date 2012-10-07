module Refinery
  module Calendar
    module CalendarHelper
      def calendar(date = Time.zone.today, &block)
        Calendar.new(self, date, block).table
      end

       class Calendar < Struct.new(:view, :date, :callback)
         
         START_DAY = :monday

         delegate :content_tag, to: :view

         def table
           content_tag :table, class: "calendar" do
             header + week_rows
           end
         end

         def header
           content_tag :tr do
             week_days.map{ |day| content_tag :th, day }.join.html_safe
           end
         end

         def week_rows
           weeks.map do |week|
             content_tag :tr do
               week.map{ |day| day_cell(day) }.join.html_safe
             end
           end.join.html_safe
         end

          def day_cell(day)
             content_tag :td, view.capture(day, &callback), class: day_classes(day)
           end
           
         def day_classes(day)
           classes = []
           classes << "today" if day == Time.zone.today
           classes << "notmonth" if day.month != date.month
           classes.empty? ? nil : classes.join("")
         end
         
         def weeks
           first = date.beginning_of_month.beginning_of_week(START_DAY)
           last = date.end_of_month.end_of_week(START_DAY)
           (first..last).to_a.in_groups_of(7)
         end
         
         def week_days
           %w[1 2 3 4 5 6 0].inject([]) do |week_days, idx|
              week_days << ::I18n.translate("date.abbr_day_names")[idx.to_i]
              week_days
            end
         end

       end


    end
  end
end

