class PagesController < ApplicationController
  
  before_filter :authenticate_user!, :except => :index
  
  def index
    @latest_posts = Post.where("is_pinned = ?", 0).limit(5)
    @pinned_posts = Post.where("is_pinned = ?", 1);
    
    @categories_top = Category.where("shows_at_home_page = ?",  true)
    @categories_side = Category.where("shows_at_sidebar = ?",  true)
    @most_posts = Post.limit(5)
    @recent_comments = Comment.limit(5)
    @comming_events = Event.limit(5)
    
    now = DateTime.now
    @beginning_of_month = DateTime.new(now.year, now.month, 1)
    @end_of_month       = DateTime.new(now.year, now.month, -1)
  end
  
  def show
    @page = Page.find_by_permalink params[:permalink]
    @pages = Page.all
  end
  
end
