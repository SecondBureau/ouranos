class EventsController < ApplicationController

  before_filter :authenticate_user!, :is_membership_expired?, :except => [:of_day]
  before_filter :check_member_confirmation

  def index
    @events_year = params[:events_year]
    @events_year.nil? ? Time.now.year : @events_year.to_i
    
    @events_by_month = Event.group_by_month_in_a_year @events_year
    # I18n.l(event.start_date, :format => "%B").capitalize
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

