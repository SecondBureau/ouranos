class SearchController < ApplicationController
  
  before_filter :authenticate_user!, :is_membership_expiried?
  
  def index
    if params[:search]
      condition = {:title_or_content_contains => params[:search]}
      @posts = Post.search(condition).all
      @events = Event.search(condition).all
    else
      @posts = []
      @events = []
    end
  end

end
