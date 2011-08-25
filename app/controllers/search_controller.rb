class SearchController < ApplicationController
  
  def index
    @search = Post.search do
      fulltext params[:search]
    end
    @results = @search.results

  end

end
