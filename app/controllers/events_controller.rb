class EventsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index]
  
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
  
  def of_day
    @date = DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
  	@events = Event.where(:start_date => @date.beginning_of_day .. @date.end_of_day)
  	respond_to do |format|
  	  format.js {render "of_day"}
	  end
  end

end
