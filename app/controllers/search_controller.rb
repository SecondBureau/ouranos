class SearchController < ApplicationController
  
  def index
    condition = {:title_or_content_contains => params[:search]}
    @posts = Post.search(condition).all
    @events = Event.search(condition).all
  end

end
