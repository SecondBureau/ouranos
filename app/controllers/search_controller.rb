class SearchController < ApplicationController
  
  def index
    @search = Post.search do
      fulltext params[:search]
    end
    @posts = @search.results
    
    @search = Event.search do
      fulltext params[:search]
    end
    @events = @search.results
    
    @results = [@posts, @events]
  end

end
