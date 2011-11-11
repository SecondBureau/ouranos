class PagesController < ApplicationController

  before_filter :authenticate_user!, :is_membership_expired?, :except => :index
  before_filter :check_member_confirmation

  def index
    if params[:calendar_option]
      calendar_events
      respond_to do |format|
    	  format.js {render "calendar"}
	    end
    end
  end

  def show
    @page = Page.find_by_permalink params[:permalink]
    @pages = Page.all
  end

end

