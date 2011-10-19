class PagesController < ApplicationController
  
  before_filter :authenticate_user!, :except => :index
  
  def index
    @latest_posts = Post.where(:is_pinned => false).limit(5)
    @pinned_posts = Post.where(:is_pinned => true);
    
    @categories_side = Category.where(:shows_at => :left)
    @most_posts = Post.limit(5)
    @recent_comments = Comment.limit(5)
    @comming_events = Event.limit(5)
    
    calendar_events
  end
  
  def show
    @page = Page.find_by_permalink params[:permalink]
    @pages = Page.all
  end
  
  private 
    def calendar_events
      calendar_option = params[:calendar_option] if params[:calendar_option]
      if params[:year] 
        year = params[:year].to_i 
      else 
        year = DateTime.now.year
      end
      if params[:month] 
        month = params[:month].to_i 
      else 
        month = DateTime.now.month
      end
      @current_date = DateTime.new(year, month, 1)
      if calendar_option
        if calendar_option == "pre"
          @current_date = @current_date - 1.month
        elsif calendar_option == "next"
          @current_date = @current_date + 1.month
        end
      end
      
      @beginning_of_month = DateTime.new(@current_date.year, @current_date.month, 1)
      @end_of_month       = DateTime.new(@current_date.year, @current_date.month, -1)
      events_in_this_month = Event.where(:start_date => @beginning_of_month.beginning_of_day .. @end_of_month.end_of_day)
      @events_day = []
      events_in_this_month.each do |event|
        @events_day << event.start_date.day
      end
      @current_day = DateTime.now
    end
  
end
