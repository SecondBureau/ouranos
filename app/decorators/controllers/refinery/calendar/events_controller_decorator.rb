Refinery::Calendar::EventsController.class_eval do

  before_filter :find_page
  
  def index
    @coming_events = Refinery::Calendar::Event.live.coming
    @previous_events = Refinery::Calendar::Event.previous.page(params[:page])
    present(@page)
  end

  protected

    def find_page
      @page = Refinery::Page.find_by_link_url("/calendar/events")
    end
    
end