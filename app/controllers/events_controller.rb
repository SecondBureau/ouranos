class EventsController < ApplicationController
  
  def index
    @years = [2011, 2012, 2013]
    @events_by_month = Event.all.group_by { |event| event.start_date.strftime("%B") }
    @events_by_month = [] if !@events_by_month
  end
  
  def show
    @event = Event.find params[:id]
  end

end
