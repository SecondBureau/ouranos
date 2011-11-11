class EventsController < ApplicationController
  
  before_filter :authenticate_user!, :is_membership_expiried?, :except => [:of_day]
  before_filter :check_member_confirmation
  
  def index
    @events_year = params[:events_year]
    if !@events_year
      @events_year = Time.now.year
    else
      @events_year = @events_year.to_i
    end
    @events_by_month = Event.all.select{|event| event.start_date.year == @events_year }.group_by { |event| I18n.l(event.start_date, :format => "%B").capitalize }
    @events_by_month = [] if !@events_by_month
  end
  
  def show
    @event = Event.find params[:id]
  end
  
  def of_day
    @date = Time.zone.parse(params[:daystring])
  	@events = Event.where(:start_date => @date.beginning_of_day.to_date .. @date.end_of_day.to_date)
  	respond_to do |format|
  	  format.js {render "of_day"}
	  end
  end

end
