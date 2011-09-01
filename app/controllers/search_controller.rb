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
  end
  
  def show
    model = param[:model].constantize
    @search = model.search do
      fulltext params[:search]
    end
    @results = @search.results
  end

end
