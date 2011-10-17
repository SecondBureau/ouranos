class EventsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index]
  
  def index
    if params[:year]
      of_day
    else
      @events = Event.all
      @events_json = []
      @events.each do |event|
        if event.end_date
          @events_json << { :start => event.start_date, :end => event.end_date, :title => event.title, :url => main_app.event_path(event) }
        else
          @events_json << { :start => event.start_date, :title => event.title, :url => main_app.event_path(event) }
        end
      end
      respond_to do |format|
        format.html
        format.json { render :json => @events_json }
      end
    end
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
