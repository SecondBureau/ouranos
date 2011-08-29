class EventsController < ApplicationController
  
  def index
    @year = params[:year]
    if !@year
      @year = Time.now.year
    else
      @year = @year.to_i
    end
    
    @events_by_month = Event.all.select{|event| event.start_date.year == @year }.group_by { |event| event.start_date.strftime("%B") }
    @events_by_month = [] if !@events_by_month
  end
  
  def show
    @event = Event.find params[:id]
  end

end
