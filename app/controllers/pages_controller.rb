class PagesController < ApplicationController
  
  def index
  end
  
  def show
    @page = Page.find_by_permalink params[:permalink]
  end
  
end
