class PagesController < ApplicationController
  
  def index
    @latest_posts = Post.limit(5)
    @latest_events = Event.limit(5)
  end
  
  def show
    @page = Page.find_by_permalink params[:permalink]
    @pages = Page.all
  end
  
end
