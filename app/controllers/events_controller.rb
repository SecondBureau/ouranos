class EventsController < ApplicationController
  
  def index
    @year = params[:year]
    if !@year
      @year = Time.now.year
    end
    @events_by_month = Event.where("start_date LIKE ?", "#{@year}%").group_by { |event| event.start_date.strftime("%B") }
    @events_by_month = [] if !@events_by_month
  end
  
  def show
    @event = Event.find params[:id]
  end

end
