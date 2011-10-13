class PagesController < ApplicationController
  
  before_filter :authenticate_user!, :except => :index
  
  def index
    @latest_posts = Post.limit(5)
    if params[:year]
    	@events = Event.where("start_date = ?", Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i))
    else
    	@events = Event.where("start_date = ?", Date.today)
    end
    @dates=Time.days_in_month(Time.now.month)
    @wday = Time.now.wday
    days = %w{SUNDAY MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY SATURDAY}
    @wday = days[@wday]
    @today = Time.now.day
    
    @categories_top = Category.where("shows_at_home_page = ?",  1)
    @categories_side = Category.where("shows_at_sidebar = ?",  1)
    @events = Event.limit(5)
    @most_posts = Post.limit(5)
    @recent_comments = Comment.limit(5)
    @comming_events = Event.limit(5)
  end
  
  def show
    @page = Page.find_by_permalink params[:permalink]
    @pages = Page.all
  end
  
end
